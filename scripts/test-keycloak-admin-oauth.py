#!/usr/bin/env python3
"""End-to-end PKCE login for Keycloak security-admin-console via edge (localhost)."""
import base64
import hashlib
import re
import secrets
import sys
from urllib.parse import parse_qs, urlencode, urlparse

import requests

BASE = "http://localhost"
AUTH = f"{BASE}/auth"
REALM = "master"
CLIENT = "security-admin-console"
REDIRECT = f"{AUTH}/admin/{REALM}/console/"
USERNAME = "admin"
PASSWORD = "admin"


def pkce_pair():
    verifier = secrets.token_urlsafe(64)[:128]
    challenge = base64.urlsafe_b64encode(
        hashlib.sha256(verifier.encode()).digest()
    ).rstrip(b"=").decode()
    return verifier, challenge


def main():
    session = requests.Session()
    session.headers.update({"User-Agent": "keycloak-admin-oauth-test/1.0"})
    verifier, challenge = pkce_pair()
    state = secrets.token_urlsafe(16)

    auth_url = (
        f"{AUTH}/realms/{REALM}/protocol/openid-connect/auth?"
        + urlencode(
            {
                "client_id": CLIENT,
                "redirect_uri": REDIRECT,
                "response_type": "code",
                "scope": "openid",
                "state": state,
                "code_challenge": challenge,
                "code_challenge_method": "S256",
            }
        )
    )

    print("1) GET authorize ...")
    r = session.get(auth_url, allow_redirects=True, timeout=30)
    print(f"   status={r.status_code} cookies={list(session.cookies.keys())}")

    if ":8000" in r.url:
        print("FAIL: redirect leaked upstream port:", r.url)
        return 1

    m = re.search(r'action="([^"]+authenticate[^"]*)"', r.text)
    if not m:
        print("FAIL: no login form in", r.url)
        return 1
    action = m.group(1).replace("&amp;", "&")

    print("2) POST login ...")
    r2 = session.post(
        action,
        data={"username": USERNAME, "password": PASSWORD, "login": "Sign In"},
        allow_redirects=False,
        timeout=30,
    )
    print(f"   status={r2.status_code} cookies={list(session.cookies.keys())}")

    if r2.status_code >= 400:
        print("FAIL: login HTTP", r2.status_code)
        print(r2.text[:400])
        return 1

    loc = r2.headers.get("Location")
    if not loc:
        print("FAIL: no redirect after login")
        return 1
    if ":8000" in loc:
        print("FAIL: post-login Location has :8000:", loc)
        return 1

    print("3) Follow redirect ...")
    r3 = session.get(loc, allow_redirects=True, timeout=30)
    print(f"   final={r3.url[:160]}")

    parsed = urlparse(r3.url)
    qs = parse_qs(parsed.query)
    if "error" in qs:
        print("FAIL: OAuth error", qs)
        return 1
    if "code" not in qs:
        print("FAIL: no code in redirect")
        return 1
    if qs.get("state", [""])[0] != state:
        print("FAIL: state mismatch")
        return 1

    code = qs["code"][0]
    print("4) POST token exchange ...")
    token_url = f"{AUTH}/realms/{REALM}/protocol/openid-connect/token"
    r4 = session.post(
        token_url,
        data={
            "grant_type": "authorization_code",
            "client_id": CLIENT,
            "redirect_uri": REDIRECT,
            "code": code,
            "code_verifier": verifier,
        },
        timeout=30,
    )
    print(f"   status={r4.status_code} body={r4.text[:220]}")
    if r4.status_code != 200:
        print("FAIL: token exchange")
        return 1

    print("OK: full OAuth admin login flow succeeded")
    return 0


if __name__ == "__main__":
    sys.exit(main())

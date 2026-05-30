#!/bin/sh

# Exclude PostHog cookies from SQL injection rule
echo 'SecRuleUpdateTargetById 942290 "!REQUEST_COOKIES:/^ph_/"' \
  > /etc/modsecurity.d/owasp-crs/rules/REQUEST-999-COMMON-EXCEPTIONS-AFTER.conf

# Exclude Vite dev assets from .js extension restriction (rule 920440)
echo 'SecRule REQUEST_URI "@beginsWith /node_modules/" "id:1001,phase:1,pass,nolog,ctl:ruleRemoveById=920440"' \
  >> /etc/modsecurity.d/owasp-crs/rules/REQUEST-999-COMMON-EXCEPTIONS-AFTER.conf

# Exclude Vite's own source files too (e.g. /src/*.jsx triggers referrer checks)
echo 'SecRule REQUEST_URI "@beginsWith /src/" "id:1002,phase:1,pass,nolog,ctl:ruleRemoveById=920440"' \
  >> /etc/modsecurity.d/owasp-crs/rules/REQUEST-999-COMMON-EXCEPTIONS-AFTER.conf

# Exclude /@vite/ and /@fs/ internal Vite paths
echo 'SecRule REQUEST_URI "@beginsWith /@" "id:1003,phase:1,pass,nolog,ctl:ruleRemoveById=920440"' \
  >> /etc/modsecurity.d/owasp-crs/rules/REQUEST-999-COMMON-EXCEPTIONS-AFTER.conf

# Keycloak OIDC: redirect_uri / iss legitimately contain http://localhost (dev) - not SSRF
echo 'SecRuleUpdateTargetById 934110 "!ARGS:redirect_uri"' \
  >> /etc/modsecurity.d/owasp-crs/rules/REQUEST-999-COMMON-EXCEPTIONS-AFTER.conf
echo 'SecRuleUpdateTargetById 934190 "!ARGS:redirect_uri"' \
  >> /etc/modsecurity.d/owasp-crs/rules/REQUEST-999-COMMON-EXCEPTIONS-AFTER.conf
echo 'SecRuleUpdateTargetById 934110 "!ARGS:post_logout_redirect_uri"' \
  >> /etc/modsecurity.d/owasp-crs/rules/REQUEST-999-COMMON-EXCEPTIONS-AFTER.conf
echo 'SecRuleUpdateTargetById 934190 "!ARGS:post_logout_redirect_uri"' \
  >> /etc/modsecurity.d/owasp-crs/rules/REQUEST-999-COMMON-EXCEPTIONS-AFTER.conf
# Admin console OAuth callback: iss=http://localhost/auth/realms/master after login
echo 'SecRuleUpdateTargetById 934110 "!ARGS:iss"' \
  >> /etc/modsecurity.d/owasp-crs/rules/REQUEST-999-COMMON-EXCEPTIONS-AFTER.conf
echo 'SecRuleUpdateTargetById 934190 "!ARGS:iss"' \
  >> /etc/modsecurity.d/owasp-crs/rules/REQUEST-999-COMMON-EXCEPTIONS-AFTER.conf

# Keycloak static assets (.js/.css under /auth/resources/)
echo 'SecRule REQUEST_URI "@beginsWith /auth/resources/" "id:1004,phase:1,pass,nolog,ctl:ruleRemoveById=920440"' \
  >> /etc/modsecurity.d/owasp-crs/rules/REQUEST-999-COMMON-EXCEPTIONS-AFTER.conf

# Keycloak session cookies can look like SQLi to rule 942290
echo 'SecRuleUpdateTargetById 942290 "!REQUEST_COOKIES:/^AUTH_SESSION_ID/"' \
  >> /etc/modsecurity.d/owasp-crs/rules/REQUEST-999-COMMON-EXCEPTIONS-AFTER.conf
echo 'SecRuleUpdateTargetById 942290 "!REQUEST_COOKIES:/^KEYCLOAK_/"' \
  >> /etc/modsecurity.d/owasp-crs/rules/REQUEST-999-COMMON-EXCEPTIONS-AFTER.conf
echo 'SecRuleUpdateTargetById 942290 "!REQUEST_COOKIES:/^KC_/"' \
  >> /etc/modsecurity.d/owasp-crs/rules/REQUEST-999-COMMON-EXCEPTIONS-AFTER.conf

# Allow AI prompts and uploaded files to contain arbitrary text/code
# (prevents SQLi/XSS/Command Injection rules from blocking legitimate AI chat context)
echo 'SecRule REQUEST_URI "@beginsWith /api/v1/ai/" "id:1005,phase:1,pass,nolog,ctl:ruleRemoveById=949110,ctl:ruleRemoveById=959100,ctl:ruleRemoveById=942100-942999,ctl:ruleRemoveById=941100-941999"' \
  >> /etc/modsecurity.d/owasp-crs/rules/REQUEST-999-COMMON-EXCEPTIONS-AFTER.conf
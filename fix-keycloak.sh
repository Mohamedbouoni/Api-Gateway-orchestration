#!/bin/bash
TOKEN=$(curl -s -X POST "http://localhost:8080/realms/master/protocol/openid-connect/token" -d "client_id=admin-cli" -d "username=admin" -d "password=admin" -d "grant_type=password" | grep -o '"access_token":"[^"]*"' | cut -d'"' -f4)

CID=$(curl -s -H "Authorization: Bearer $TOKEN" "http://localhost:8080/admin/realms/newRealm/clients?clientId=myclient" | grep -o '"id":"[^"]*"' | head -1 | cut -d'"' -f4)

curl -s -X PUT "http://localhost:8080/admin/realms/newRealm/clients/$CID" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"clientId":"myclient","redirectUris":["https://departure-uneatable-tattle.ngrok-free.dev/*","http://localhost:5173/*"],"webOrigins":["https://departure-uneatable-tattle.ngrok-free.dev","http://localhost:5173","*"]}'

echo "Done! Keycloak redirect updated."

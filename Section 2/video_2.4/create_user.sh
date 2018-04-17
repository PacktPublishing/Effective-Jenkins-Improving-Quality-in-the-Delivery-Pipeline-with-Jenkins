#!/bin/sh
echo "Creating Maria:"
curl -H "Content-Type: application/json" \
-X POST \
-d '{"name":"Maria"}' \
http://192.168.50.6:8080/user/new

echo "\nCreating Julia:"
curl -H "Content-Type: application/json" \
-X POST \
-d '{"name":"Julia", "email":"julia@juliainc.com"}' \
http://192.168.50.6:8080/user/new

echo "\nListing all users:"
curl http://192.168.50.6:8080/user/all | python -mjson.tool

# For more info, see repo: notes
# VPN blog
https://code.mendhak.com/run-docker-through-vpn-container/
# Force re-create all containers. Not sure if all is needed
docker-compose up --force-recreate --remove-orphans -d --always-recreate-deps --build


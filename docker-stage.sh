docker-compose down
yarn install
yarn staging
docker-compose up -d --build
docker image prune -f
docker-compose down
yarn install
yarn build
docker-compose up -d --build
docker image prune -f
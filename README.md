# docker-php7.4-nginx-mariadb
1. Create folder www
2. Put your project in www folder
3. Rename .env.example file to .env, change db root username and db root password as your wish. Don't forgets to change username and password db settings in your project configs.
4. run command "sudo docker volume create --name=mariadb_data"
5. run command "sudo docker-compose up"

docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' container_name_or_id - получить ip контейнера

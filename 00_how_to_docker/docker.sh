# 01 
docker-machine create --driver virtualbox Char

# 02
docker-machine ip Char

# 03 : must replqce 'eval' with not a builtin
eval $(docker-machine env Char)
docker ps

# 04
docker pull hello-world

# 05
docker run hello-world

# 06
docker pull nginx
# d = bakground
# p = port forwarding
docker run -d --name overlord -p 5000:80 --restart always nginx 

# 07
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' overlord

# 08 For interactive processes (like a shell), you must use -i -t together
docker pull alpine
docker run -it --rm alpine /bin/sh
docker ps -a

# 09
docker pull debian
docker run -it debian /bin/sh

apt-get update
apt-get upgrade -y
apt-get install nano
apt-get install build-essential
apt-get install git
exit

# 10
docker volume create --name hatchery

# 11
docker volume list

# 12
docker run -d --name spawning-pool \
	-e MYSQL_ROOT_PASSWORD=Kerrigan \
	-e MYSQL_DATABASE=zerglings \
	-v hatchery:/var/lib/mysql \
	--restart on-failure:10 \
	mysql \
	--default-authentication-plugin=mysql_native_password 

# 13
docker exec spawning-pool env
#Or docker inspect -f '{{.Config.Env}}' spawning-pool

# 14
docker run -d --name lair \
	--link spawning-pool:mysql \
	-p 8080:80 \
	wordpress
# 15
docker run -d --name roach-warden --link spawning-pool:db -p 8081:80 phpmyadmin/phpmyadmin

# 16
docker logs -f spawning-pool

# 17
docker ps

# 18
docker container restart overlord

# 19
docker run --name Abathur -v ~/:/root -p 3000:3000 -dit python:2-slim
docker exec Abathur pip install Flask
echo \
'from flask import Flask
app = Flask(__name__)
@app.route("/")\ndef hello_world():
	return "<h1>Hello, World!</h1>"' > ~/flask_app.py
docker exec -e FLASK_APP=/root/flask_app.py Abathur flask run --host=0.0.0.0 --port 3000

# 20
docker swarm init --advertise-addr $(docker-machine ip Char)
#Or docker-machine ssh Char "docker swarm init --advertise-addr $(docker-machine ip Char)"
# 21
docker-machine create --driver virtualbox Aiur

# 22 -q = only task id
docker-machine ssh Aiur "docker swarm join --token $(docker swarm join-token worker -q) $(docker-machine ip Char):2377"

# 23
docker network create -d overlay overmind

# 24
docker service create -d --name orbital-command --network overmind -e RABBITMQ_DEFAULT_USER=root -e RABBITMQ_DEFAULT_PASS=root rabbitmq

# 25
docker service ls

# 26
docker service create -d --name engineering-bay --network overmind --replicas 2 -e OC_USERNAME=root -e OC_PASSWD=root 42school/engineering-bay

# 27
docker service logs -f $(docker service ps engineering-bay -f "name=engineering-bay.1" -q)

# 28
docker service create -d --name marines --network overmind --replicas 2 -e OC_USERNAME=root -e OC_PASSWD=root 42school/marine-squad

# 29
docker service ps marines

# 30
docker service scale -d marines=20

# 31
docker service rm $(docker service ls -q)

# 32
docker rm -f $(docker ps -a -q)

# 33
docker rmi $(docker images -a -q)

# 34
docker-machine rm -y Aiur

# TO CLEAN REST

docker volume rm $(docker volume ls -q)
docker-machine rm -y Char

# TO BUILD IMAGE

# docker build -t ex00 ex00
# docker run --rm -ti ex00


# docker build -t ex01 ex01
# docker run --rm -p 9987:9987/udp -p 10011:10011 -p 30033:30033 ex01

# docker build -t ex02 ft-rails:on-build
# docker build -t ex02 test
# docker run -it --rm -p 3000:3000 ex02




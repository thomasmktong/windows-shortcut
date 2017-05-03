docker rm -f @(docker ps -aq)
docker rmi -f @(docker image -aq)
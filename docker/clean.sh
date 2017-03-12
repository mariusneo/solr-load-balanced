docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker rmi docker_lb
docker rmi docker_solr-master
docker rmi docker_solr-slave

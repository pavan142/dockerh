filename="DockerH"
if [[ -z "${DOCKERH_MODULE_NAME}" ]]; then
  if [ -f "$filename" ]; then
    DOCKERH_MODULE_NAME=$(head -1 $filename)
  else
      DOCKERH_MODULE_NAME=$(cat /dev/urandom | tr -dc 'a-z' | fold -w 10 | head -n 1)
      echo $DOCKERH_MODULE_NAME > $filename
  fi
fi

export CONTAINER_NAME="cont-$DOCKERH_MODULE_NAME"
export IMAGE_NAME="image-$DOCKERH_MODULE_NAME"

# echo "Module: $DOCKERH_MODULE_NAME"
# echo "Container: $CONTAINER_NAME"
# echo "Image: $IMAGE_NAME"

commit() {
  docker image build -t $IMAGE_NAME . 
}

update() {
  docker_env_file="docker-env"
  if [ -f "$docker_env_file" ]; then
    echo "docker-env file found, setting environment variables"
    docker kill $CONTAINER_NAME; docker rm $CONTAINER_NAME; docker create -t -i --network='host' --env-file ./docker-env --name $CONTAINER_NAME $IMAGE_NAME
  else
    echo "docker-env file not found, it's okay , it's not mandatory"
    docker kill $CONTAINER_NAME; docker rm $CONTAINER_NAME; docker create -t -i --network='host' --name $CONTAINER_NAME $IMAGE_NAME
  fi
}

clear() {
  docker image prune -a -f
}

start() {
  docker start -i $CONTAINER_NAME
}

stop() {
  docker stop $CONTAINER_NAME
}

logs() {
  docker attach $CONTAINER_NAME
}

status() {
  docker ps -a -f "name=${CONTAINER_NAME}"
}

join() {
  docker exec -i -t $CONTAINER_NAME bash
}

case $1 in

  "commit")
  commit
    ;;

  "update")
  update
    ;;

  "clear")
  clear
    ;;

  "status")
  status
    ;;

  "logs")
  logs
    ;;

  "stop")
  stop
    ;;
  
  "start")
  start
    ;;

  "join")
  join
    ;;
  *)
    echo "I am sorry, but I don't know how to process that!"
    ;;
esac

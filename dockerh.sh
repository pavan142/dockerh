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
  env-file-option=""
  docker-env-file="docker-env.txt"
  if [ -f "$docker-env-file" ]; then
    docker kill $CONTAINER_NAME; docker rm $CONTAINER_NAME; docker create -t -i --network='host' --env-file ./docker-env --name $CONTAINER_NAME $IMAGE_NAME
  else
    docker kill $CONTAINER_NAME; docker rm $CONTAINER_NAME; docker create -t -i --network='host' --name $CONTAINER_NAME $IMAGE_NAME
  fi
}

clear() {
  docker image prune -f
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
  *)
    echo "I am sorry, but I don't know how to process that!"
    ;;
esac
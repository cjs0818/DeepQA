DOCKER=docker
#DOCKER=nvidia-docker

$DOCKER run -it --rm \
 --name deepqa \
 --env DISPLAY=$DISPLAY \
 --env="QT_X11_NO_MITSHM=1" \
 --volume /tmp/.X11-unix:/tmp/.X11-unix:ro \
 --volume /home/jschoi/work/LSTM:/root:rw \
 -p 8888:8888 \
 -p 6006:6006 \
 deepqa:latest \
 bash

 #--volume /home/jschoi/work/LSTM:/root/work:rw \

# gcr.io/tensorflow/tensorflow:latest-gpu \

#nvidia-docker run -it --rm \
# --name tensorlayer \
# --volume /home/jschoi/work/LSTM:/root/work:rw \
# -p 8888:8888 \
# -p 6006:6006 \
# pristine70/tensorlayer

DOCKER=docker
#DOCKER=nvidia-docker

#---------------------------
OS=OSX
#OS=Linux

GPU=0
#GPU=1

EN0=en0
#EN0=enp0s5
#EN0=enp0s31f6

DISPLAY_IP=$(ifconfig $EN0 | grep inet | awk '$1=="inet" {print $2}')

if [ $OS = "OSX" ]
then
  DOCKER=docker
  XDISP=DISPLAY=$DISPLAY_IP:0  # for OSX
  WORKDIR=/Users/jschoi/work/LSTM
  ./socat_start.sh &
else
  if [ $GPU = 1 ]
  then
    DOCKER=nvidia-docker
  else
    DOCKER=docker
  fi
  XDISP="DISPLAY"             # for Linux
  WORKDIR=/home/jschoi/work/LSTM
  xhost +
fi

#---------------------------

$DOCKER run -it --rm \
 --name deepqa \
 --env $XDISP \
 --env="QT_X11_NO_MITSHM=1" \
 --volume /tmp/.X11-unix:/tmp/.X11-unix:ro \
 --volume $WORKDIR:/root:rw \
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

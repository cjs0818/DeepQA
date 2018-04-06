nvidia-docker run -it --rm \
 --name deepqa_gpu \
 --volume /home/jschoi/work/LSTM:/roo:rw \
 -p 8888:8888 \
 -p 6006:6006 \
 deepqa:latest-gpu \
 bash

 #--volume /home/jschoi/work/LSTM:/root/work:rw \

# gcr.io/tensorflow/tensorflow:latest-gpu \

#nvidia-docker run -it --rm \
# --name tensorlayer \
# --volume /home/jschoi/work/LSTM:/root/work:rw \
# -p 8888:8888 \
# -p 6006:6006 \
# pristine70/tensorlayer

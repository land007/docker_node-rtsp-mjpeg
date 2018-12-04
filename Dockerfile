FROM land007/node:latest

MAINTAINER Yiqiu Jia <yiqiujia@hotmail.com>

#RUN . $HOME/.nvm/nvm.sh && npm install rtsp-ffmpeg

#RUN ln -s $HOME/.nvm/versions/node/$SHIPPABLE_NODE_VERSION/lib/node_modules /node_
# Define working directory.
#RUN mkdir /node
ADD node /node_
RUN ls /node_
RUN sed -i 's/\r$//' /node_/start.sh && chmod a+x /node_/start.sh

ENV CAMLIST=rtsp://admin:Admin123@192.168.0.241:554/h264/ch1/main/av_stream
ENV WH=1024x576
ENV QUALITY=3

#docker push registry.eyecool.cn:5080/node-rtsp-mjpeg:latest
#docker pull registry.eyecool.cn:5080/node-rtsp-mjpeg:latest; docker kill debian_node-rtsp-mjpeg; docker rm debian_node-rtsp-mjpeg; docker run -it --privileged -p 8801:80 --name debian_node-rtsp-mjpeg -e "CAMLIST=rtsp://admin:Admin123@192.168.0.241:554/h264/ch1/main/av_stream" -e "WH=1188x668" registry.eyecool.cn:5080/node-rtsp-mjpeg:latest

#docker pull land007/node-rtsp-mjpeg:latest; docker kill debian_node-rtsp-mjpeg; docker rm debian_node-rtsp-mjpeg; docker run -it --privileged -p 8801:80 --name debian_node-rtsp-mjpeg -e "CAMLIST=rtsp://admin:Admin123@192.168.0.241:554/h264/ch1/sub/av_stream" -e "WH=1188x668" land007/node-rtsp-mjpeg:latest
#docker pull land007/node-rtsp-mjpeg:latest; docker kill debian_node-rtsp-mjpeg; docker rm debian_node-rtsp-mjpeg; docker run -it --privileged -p 8801:80 --name debian_node-rtsp-mjpeg -e "CAMLIST=rtsp://admin:Admin123@192.168.0.241:554/h264/ch1/main/av_stream" -e "WH=1188x668" land007/node-rtsp-mjpeg:latest

#docker pull land007/node-rtsp-mjpeg:latest; docker kill debian_node-rtsp-mjpeg; docker rm debian_node-rtsp-mjpeg; docker run -it --privileged -p 8801:80 --name debian_node-rtsp-mjpeg -e "CAMLIST=rtsp://admin:Admin123@192.168.0.241:554/h264/ch1/main/av_stream" -e "WH=1188x668" registry.eyecool.cn:5080/node-rtsp-mjpeg:latest

#shangke
#docker pull registry.eyecool.cn:5080/node-rtsp-mjpeg:latest; docker kill debian_node-rtsp-mjpeg; docker rm debian_node-rtsp-mjpeg; docker run -it --privileged -p 80:80 --name debian_node-rtsp-mjpeg -e "CAMLIST=rtsp://admin:Admin123@192.168.0.241:554/h264/ch1/main/av_stream" -e "WH=1188x668" registry.eyecool.cn:5080/node-rtsp-mjpeg:latest

#docker pull registry.eyecool.cn:5080/node-rtsp-mjpeg:latest; docker kill debian_node-rtsp-mjpeg; docker rm debian_node-rtsp-mjpeg; docker run -it --privileged -p 80:80 --name debian_node-rtsp-mjpeg -e "CAMLIST=rtsp://admin:abcd1234@172.16.0.104:554" -e "WH=1188x668" -e "QUALITY=1" registry.eyecool.cn:5080/node-rtsp-mjpeg:latest
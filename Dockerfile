FROM land007/node:latest

MAINTAINER Yiqiu Jia <yiqiujia@hotmail.com>

RUN . $HOME/.nvm/nvm.sh && npm install node-rtsp-stream
RUN apt-get update && apt-get install -y ffmpeg && apt-get clean
RUN . $HOME/.nvm/nvm.sh && npm install -g http-server

ADD main.js /node/main.js
ADD index.html /node/index.html
ADD jsmpeg.min.js /node/jsmpeg.min.js

RUN echo "/usr/bin/nohup http-server -a 0.0.0.0 -p 8000 & > /tmp/node.out 2>&1&" > /node/start_webserver.sh
RUN ls /node/
RUN chmod +x /node/start_webserver.sh
ENV PATH $PATH:/root/.nvm/versions/node/$SHIPPABLE_NODE_VERSION/bin/
RUN ls /
RUN which http-server
RUN ls /node/node_modules
ADD node_modules/node-rtsp-stream/lib/mpeg1muxer.js /node/node_modules/node-rtsp-stream/lib/mpeg1muxer.js
ADD check.sh /
RUN sed -i 's/\r$//' /check.sh
RUN chmod a+x /check.sh
RUN rm -rf /node_ && mv /node /node_
ENV RTSPURL=rtsp://admin:abcd1234@192.168.0.234:554/cam/realmonitor?channel=1&subtype=1
ENV WH=1024x576

CMD /check.sh /node ; /etc/init.d/ssh start && /node/start_webserver.sh && supervisor -w /node/ /node/main.js
EXPOSE 8000/tcp 8100/tcp

#docker pull land007/node-rtsp-mjpeg:latest; docker kill debian_node-rtsp-stream; docker rm debian_node-rtsp-stream; docker run -it --restart always --privileged -p 8000:8000 -p 8100:8100 --name debian_node-rtsp-stream -e "RTSPURL=rtsp://admin:Admin123@192.168.0.241:554/h264/ch1/sub/av_stream" -e "WH=1024x576" land007/node-rtsp-mjpeg:latest
#docker kill debian_node-rtsp-stream; docker kill debian_node-rtsp-stream1; docker rm debian_node-rtsp-stream1; docker run -it --privileged -p 8000:8000 -p 8100:8100 --name debian_node-rtsp-stream1 -e "RTSPURL=rtsp://admin:Admin123@192.168.0.241:554/h264/ch1/sub/av_stream" -e "WH=880x660" land007/node-rtsp-mjpeg:latest
#docker kill debian_node-rtsp-stream; docker kill debian_node-rtsp-stream1; docker rm debian_node-rtsp-stream1; docker run -it --privileged -p 8000:8000 -p 8100:8100 --name debian_node-rtsp-stream1 -e "RTSPURL=rtsp://admin:Admin123@192.168.0.241:554/h264/ch1/sub/av_stream" -e "WH=890x668" land007/node-rtsp-mjpeg:latest
#docker kill debian_node-rtsp-stream; docker kill debian_node-rtsp-stream1; docker rm debian_node-rtsp-stream1; docker run -it --privileged -p 8000:8000 -p 8100:8100 --name debian_node-rtsp-stream1 -e "RTSPURL=rtsp://admin:Admin123@192.168.0.241:554/h264/ch1/sub/av_stream" -e "WH=1188x668" land007/node-rtsp-mjpeg:latest
#docker kill debian_node-rtsp-stream; docker kill debian_node-rtsp-stream1; docker rm debian_node-rtsp-stream1; docker run -it --privileged -p 8000:8000 -p 8100:8100 --name debian_node-rtsp-stream1 -e "RTSPURL=rtsp://admin:Admin123@192.168.0.241:554/h264/ch1/sub/av_stream" -e "WH=1188x668" land007/node-rtsp-mjpeg:latest


FROM ubuntu:16.04
MAINTAINER Thoyib Antarnusa

RUN apt-get update && apt-get -y install software-properties-common build-essential wget git

RUN add-apt-repository ppa:bartbes/love-stable -y
RUN apt-get update
RUN mkdir /home/temp; cd /home/temp && \
    wget https://luarocks.org/releases/luarocks-2.4.1.tar.gz && \
    tar zxpf luarocks-2.4.1.tar.gz && \
    wget https://nih.at/libzip/libzip-1.3.0.tar.gz && \
    tar zxpf libzip-1.3.0.tar.gz
 
RUN apt-get install -qq lua5.1 lua5.1-dev lua5.2 lua5.2-dev
RUN apt-get install -qq love
RUN apt-get install -qq zip libzip-dev
RUN cd /home/temp/luarocks-2.4.1 && \
    ./configure --lua-version=5.1 --versioned-rocks-dir --lua-suffix=5.1 && \
    make build && \
    make install
RUN cd /home/temp/libzip-1.3.0 && \
    ./configure && \
    make && \
    make install
 
RUN rm -rf /home/temp
 
RUN luarocks-5.1 install --server=http://luarocks.org/dev lua-zip
RUN luarocks-5.1 install love-release

RUN mkdir -p /osg/
WORKDIR /osg/

COPY . /osg/
RUN love-release -D -a "Mgs. M. Thoyib Antarnusa" -d "A simple open source snake game." -e "tybantarnusa@null.net" -u "tybantarnusa.com" -v "0.0.1"

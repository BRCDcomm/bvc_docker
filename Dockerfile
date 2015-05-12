# Copyright (c) 2015,  BROCADE COMMUNICATIONS SYSTEMS, INC
# 
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without modification,
#  are permitted provided that the following conditions are met:
# 
# 1. Redistributions of source code must retain the above copyright notice, this 
# list of conditions and the following disclaimer.
# 
# 2. Redistributions in binary form must reproduce the above copyright notice, 
# this list of conditions and the following disclaimer in the documentation and/or 
# other materials provided with the distribution.
# 
# 3. Neither the name of the copyright holder nor the names of its contributors 
# may be used to endorse or promote products derived from this software without 
# specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE 
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE 
# GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) 
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT 
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT 
# OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


FROM ubuntu:14.04
RUN apt-get update && apt-get install -y wget zip unzip curl openssh-server psmisc
RUN curl -sL https://deb.nodesource.com/setup | bash
RUN apt-get install -y nodejs 
WORKDIR /opt
RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u71-b14/server-jre-7u71-linux-x64.tar.gz  && tar xzf server-jre-7u71-linux-x64.tar.gz && rm -rf server-jre-7u71-linux-x64.tar.gz
RUN mkdir bvc
COPY bvc-1.2.0.zip /opt/
RUN unzip -o bvc-1.2.0.zip -d /opt && rm -rf bvc-1.2.0.zip
COPY bvc-dependencies-1.2.0.zip /opt/
RUN unzip -o bvc-dependencies-1.2.0.zip -d /opt && rm -rf bvc-dependencies-1.2.0.zip
WORKDIR /opt/bvc
ENV JAVA_HOME /opt/jdk1.7.0_71/jre
RUN curl -sL https://github.com/alrooney/bvc_docker/raw/master/web.zip -o web.zip
EXPOSE 162 179 1088 1790 1830 2400 2550 2551 2552 4189 4342 5005 5666 6633 6640 6653 7800 8000 8080 8101 8181 8383 9000 12001
# note - installing at runtime since the install hardcodes the ip address in places and controller does not work correctly if ip changes
CMD /opt/bvc/install -i && unzip -o web.zip && rm -f web.zip && /opt/bvc/bin/taillog
 
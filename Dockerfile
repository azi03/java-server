FROM frolvlad/alpine-glibc:latest
LABEL MAINTAINER="azi<azi03@qq.com>"
ADD server-jre-8u251-linux-x64.tar.gz /usr/java/jdk/
ADD pinpoint-agent-2.2.0.tar.gz /pinpoint/agent
COPY Shanghai /usr/share/zoneinfo/Asia/
COPY jstatd.all.policy ${JAVA_HOME}/bin

RUN mkdir -p /usr/share/zoneinfo/Asia \
	&& ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
	&& echo "Asia/Shanghai" > /etc/timezone

ENV JAVA_HOME /usr/java/jdk/jdk1.8.0_251 \
	PATH ${PATH}:${JAVA_HOME}/bin \
	PINPOINT_HOME /pinpoint/agent/pinpoint-agent-2.2.0 \
	pinpoint.agentId default \
	pinpoint.applicationName default \
	profiler.transport.grpc.collector.ip 127.0.0.3 \
	PINPOINT_OPTIONS -javaagent:$PINPOINT_HOME/pinpoint-bootstrap.jar


RUN apk update \
        && apk upgrade \
        && apk add --no-cache bash \
        bash-doc \
        bash-completion \
        && rm -rf /var/cache/apk/* \
        && /bin/bash
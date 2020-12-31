FROM frolvlad/alpine-glibc:latest
LABEL MAINTAINER="azi<azi03@qq.com>"
ADD server-jre-8u251-linux-x64.tar.gz /usr/java/jdk/
ADD pinpoint-agent-2.2.0.tar.gz /pinpoint/agent

RUN mkdir -p /usr/share/zoneinfo/Asia
COPY Shanghai /usr/share/zoneinfo/Asia/
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo "Asia/Shanghai" > /etc/timezone

ENV JAVA_HOME /usr/java/jdk/jdk1.8.0_251
COPY jstatd.all.policy ${JAVA_HOME}/bin

ENV PINPOINT_AGENT_ID default
ENV PINPOINT_APP_NAME default
ENV PINPOINT_COLLECTOR_IP 127.0.0.1
ENV PINPOINT_OPTIONS -javaagent:/pinpoint/agent/pinpoint-agent-2.2.0/pinpoint-bootstrap-2.2.0.jar -Dpinpoint.agentId=\$PINPOINT_AGENT_ID -Dpinpoint.applicationName=\$PINPOINT_APP_NAME -Dprofiler.transport.grpc.collector.ip=\$PINPOINT_COLLECTOR_IP

ENV PATH ${PATH}:${JAVA_HOME}/bin

RUN apk update \
        && apk upgrade \
        && apk add --no-cache bash \
        bash-doc \
        bash-completion \
        && rm -rf /var/cache/apk/* \
        && /bin/bash
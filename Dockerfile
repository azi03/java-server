FROM frolvlad/alpine-glibc:latest
LABEL MAINTAINER="azi<azi03@qq.com>"

# 替换阿里云的源
RUN echo "http://mirrors.aliyun.com/alpine/latest-stable/main/" > /etc/apk/repositories
RUN echo "http://mirrors.aliyun.com/alpine/latest-stable/community/" >> /etc/apk/repositories

ENV JAVA_HOME=/usr/java/jdk/jdk1.8.0_251
ENV PATH=${PATH}:${JAVA_HOME}/bin
ENV TZ=Asia/Shanghai

ADD server-jre-8u251-linux-x64.tar.gz $JAVA_HOME/../
ADD Shanghai /usr/share/zoneinfo/Asia/
COPY jstatd.all.policy ${JAVA_HOME}/bin/

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
	&& echo "Asia/Shanghai" > /etc/timezone \
	&& apk update \
    && apk upgrade \
    && apk add --no-cache bash \
    	bash-doc \
    	bash-completion \
	&& mkdir -p $JAVA_HOME/jre/lib/security \
	&& cp $JAVA_HOME/jre/lib/security/policy/unlimited/* $JAVA_HOME/jre/lib/security \
    && rm -rf /var/cache/apk/* \
    && /bin/bash
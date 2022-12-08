FROM centos:7

ENV MYPATH /usr/local
WORKDIR $MYPATH
COPY . /usr/local
RUN mv makerom /usr/bin/
RUN mv ctrtool /usr/bin/
RUN yum install -y epel-release
RUN yum install -y gcc python-devel python-pip
RUN pip install -r requirements.txt -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com


CMD /bin/bash
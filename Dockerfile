FROM amazonlinux:latest

# update all
RUN yum update -y \
    && yum install -y git

# install latest pip
RUN curl https://bootstrap.pypa.io/get-pip.py | python

# install python libs for use aws api, ansible
RUN pip install --upgrade pip \
    && pip install boto boto3 awscli ansible

# add ansible config
ADD ./ansible/configs/ansible.cfg /root/.ansible.cfg

# install initscripts for user /sbin/init
RUN yum install -y initscripts

# copy ssh keys
ADD ./ansible/ssh/ /root/.ssh/
RUN chmod 700 /root/.ssh
RUN chmod 600 /root/.ssh/*

# change work dir
RUN mkdir /ansible
WORKDIR /ansible

CMD ["/sbin/init", "-D"]
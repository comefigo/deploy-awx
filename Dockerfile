FROM centos:6

# copy ssh keys
ADD ./ansible/ssh/ /root/.ssh/
RUN chmod 700 /root/.ssh
RUN chmod 600 /root/.ssh/*

# update yum and install python
RUN yum install -y https://centos6.iuscommunity.org/ius-release.rpm
RUN yum install -y python35u python35u-pip upstart

# overwrite symbolic link
RUN ln -sf /usr/bin/python3.5 /usr/bin/python

# install pip
RUN curl https://bootstrap.pypa.io/get-pip.py | python

# add pip symbolic link
RUN ln -sf /usr/bin/pip3.5 /usr/bin/pip

# install python libs for use aws api, ansible
RUN pip install --upgrade pip \
    && pip install boto boto3 ansible

# add ansible config
ADD ./ansible/configs/ansible.cfg /root/.ansible.cfg

# change work dir
RUN mkdir /ansible
WORKDIR /ansible

CMD ["/sbin/init", "-D"]
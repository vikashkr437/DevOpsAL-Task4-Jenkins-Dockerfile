FROM centos:7


RUN yum install java-1.8.0-openjdk-devel -y
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv kubectl /usr/bin/
RUN mkdir /root/.kube/
COPY config   /root/.kube/
COPY ca.crt   /root/
COPY client.key  /root/
COPY client.crt  /root/
RUN mkdir /jenkins-launch
RUN yum install openssh-server -y
RUN yum install net-tools -y
RUN echo 'root:redhat' | chpasswd
RUN /usr/bin/ssh-keygen -A
EXPOSE 22
CMD /usr/sbin/sshd -D

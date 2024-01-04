# Set the base image
ARG BASE_IMAGE_TAG=${BASE_IMAGE_TAG}
FROM ubuntu:${BASE_IMAGE_TAG}

# Set ARG
ARG TZ=Asia/Tokyo
ARG USER_NAME=${USER_NAME}
ARG KUBECTL_VERSION=${KUBECTL_VERSION}

# Set TimeZone
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone

# Repository Update
RUN apt-get update -y &&\
    apt-get upgrade -y

# Install Packages
RUN apt-get install apt-transport-https -y &&\
    apt-get install curl -y &&\
    apt-get install git -y &&\
    apt-get install gnupg2 -y &&\
    apt-get install software-properties-common -y &&\
    apt-get install sudo -y &&\
    apt-get install unzip -y &&\
    apt-get install vim -y &&\
    apt-get install wget -y &&\
    apt-get install zip -y

# Install awscliv2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" &&\
    unzip awscliv2.zip &&\
    ./aws/install &&\
    rm awscliv2.zip

# Add User
RUN adduser ${USER_NAME} --force-badname

# Setup to use sudo without password
RUN echo "${USER_NAME} ALL=NOPASSWD: ALL" >> /etc/sudoers

# Setup WORKDIR
WORKDIR /home/${USER_NAME}

# Change User
USER ${USER_NAME}

# Install kubectl
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - &&\
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list &&\
    sudo apt-get update &&\
    sudo apt-get install kubectl -y

# Install helm
RUN curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null &&\
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list &&\
    sudo apt-get update &&\
    sudo apt-get install helm

# Install eksctl
RUN curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp &&\
    sudo mv /tmp/eksctl /usr/local/bin

# Create .aws files
RUN mkdir ~/.aws &&\
    touch ~/.aws/config &&\
    touch ~/.aws/credentials &&\
    chmod 600 ~/.aws/config &&\
    chmod 600 ~/.aws/credentials

# Deploy aws_cli_credentials_manager.sh
COPY ./aws_cli_credentials_manager.sh /home/${USER_NAME}/.aws/
RUN sudo chown ${USER_NAME}:${USER_NAME} ~/.aws/aws_cli_credentials_manager.sh &&\
    chmod 700 ~/.aws/aws_cli_credentials_manager.sh

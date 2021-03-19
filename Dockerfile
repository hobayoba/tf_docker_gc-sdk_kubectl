FROM debian:10.7

ENV DEBIAN_FRONTEND noninteractive
RUN apt update -qq && \
    apt install apt-transport-https ca-certificates gnupg gnupg-agent software-properties-common curl unzip -yqq

ENV TF_BIN_VERSION 0.13.6
RUN curl --silent --show-error --fail --location --output /tmp/terraform.zip https://releases.hashicorp.com/terraform/${TF_BIN_VERSION}/terraform_${TF_BIN_VERSION}_linux_amd64.zip && \
    unzip -d /usr/bin /tmp/terraform.zip && \
    rm -rf /tmp/terraform.zip

ENV DOCKER_VER 5:20.10.2~3-0~debian-buster
ENV GC_SDK_VER 325.0.0-0
ENV KUBECTL_VER 1.20.2-00
RUN curl --silent --show-error --fail https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - && \
    curl --silent --show-error --fail https://download.docker.com/linux/debian/gpg | apt-key add - && \
    echo "deb [arch=amd64] https://download.docker.com/linux/debian buster stable" | tee -a /etc/apt/sources.list.d/docker.list && \
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    apt-get update -qq && \
    apt-get install google-cloud-sdk=${GC_SDK_VER} kubectl=${KUBECTL_VER} docker-ce=${DOCKER_VER} docker-ce-cli containerd.io -yqq && \
    rm -rf /var/cache/apt/* /var/lib/apt/lists
COPY check.sh /check.sh

ENV PATH /usr/local/bin:/usr/bin:/bin

CMD ["/check.sh"]

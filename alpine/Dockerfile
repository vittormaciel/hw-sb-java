FROM alpine:latest

LABEL BASE_IMAGE="Alpine Latest Version"
LABEL KUBERNETES="kubectl"

RUN apk --no-cache add curl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" 
RUN chmod +x ./kubectl
RUN export KUBECONFIG=$config
RUN mkdir -p $HOME/bin
RUN cp ./kubectl $HOME/bin/kubectl
RUN export PATH=$HOME/bin:$PATH

CMD ["kubectl"]

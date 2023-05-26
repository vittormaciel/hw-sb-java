FROM alpine:latest

LABEL BASE_IMAGE="Alpine Latest Version"
LABEL KUBERNETES="kubectl"

RUN apk --no-cache add curl \
&& curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
&& chmod +x ./kubectl \
&& mv ./kubectl /usr/bin/kubectl

ENTRYPOINT ["kubectl"]

CMD ["help"]
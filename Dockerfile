FROM busybox:1 AS builder

ARG k8sversion=v1.18.0

RUN wget -O kubectl https://storage.googleapis.com/kubernetes-release/release/$k8sversion/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /bin/kubectl
	
FROM scratch
COPY --from=builder /bin/kubectl /kubectl
	
EXPOSE 8001
ENTRYPOINT ["/kubectl", "proxy"]
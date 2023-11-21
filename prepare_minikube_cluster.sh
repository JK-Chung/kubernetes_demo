#!/bin/bash
minikube image build image_versions/first_version/Dockerfile -t demo-nginx-server:v1
minikube image build image_versions/second_version/Dockerfile -t demo-nginx-server:v2

minikube kubectl -- apply -f kubernetes_manifests/base_namespace.yaml
minikube kubectl -- apply -f kubernetes_manifests/demo_nginx_server_service.yaml

# Deploy version v1 of the image
cat kubernetes_manifests/demo_nginx_server_deployment.yaml | TAG_VERSION=v1 envsubst | minikube kubectl -- -n demo-application apply -f -

# Deploy version v2 of the image
cat kubernetes_manifests/demo_nginx_server_deployment.yaml | TAG_VERSION=v2 envsubst | minikube kubectl -- -n demo-application apply -f -
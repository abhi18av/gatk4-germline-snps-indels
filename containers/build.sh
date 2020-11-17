#!/bin/bash

# NOTE: An example of building and pushing multiple containers to ECR registry.
# TODO: Please modify this script for your own use-case.

REGISTRY="ecr/REGISTRY"
for container_dir in $(find * -type d); do
  echo "Building $container_dir ..."
  cd $container_dir
  aws ecr create-repository \
    --repository-name $container_dir \
    --image-scanning-configuration scanOnPush=false \
    --region eu-west-1
  docker build -t $REGISTRY/$container_dir:0.0.1 .
  docker push $REGISTRY/$container_dir:0.0.1
  cd ..
done

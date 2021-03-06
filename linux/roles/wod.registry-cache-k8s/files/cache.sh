#!/bin/bash

set -e

REGISTRY_LOCAL="${REGISTRY_LOCAL:-}"
REGISTRY_REMOTE="${REGISTRY_REMOTE:-}"
REGISTRY_DATA_PATH="${REGISTRY_DATA_PATH:-}"
ITEM_REPO="${ITEM_REPO:-}"
ITEM_VERSION="${ITEM_VERSION:-}"

mkdir -p /etc/kubernetes/downloads
mkdir -p /etc/kubernetes/data

if ! [[ -e $REGISTRY_DATA_PATH/docker/registry/v2/repositories/k8s/$ITEM_REPO/_manifests/tags/$ITEM_VERSION ]]; then
  docker pull $REGISTRY_REMOTE$ITEM_REPO:$ITEM_VERSION
  docker tag $REGISTRY_REMOTE$ITEM_REPO:$ITEM_VERSION $REGISTRY_LOCAL$ITEM_REPO:$ITEM_VERSION
  docker push $REGISTRY_LOCAL$ITEM_REPO:$ITEM_VERSION 
fi
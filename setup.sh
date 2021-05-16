#!/bin/bash

LANG=C
SLEEP_SECONDS=45

OVERLAY=dex

if [ $# -gt 0 ]; then
    OVERLAY=$1
    echo "No overlay specified, using overlay $1"
fi

exit 0;

echo ""
echo "Installing GitOps Operator."

kustomize build openshift-gitops-operator/overlays/dex | oc apply -f -

echo "Pause $SLEEP_SECONDS seconds for the creation of the gitops-operator..."
sleep $SLEEP_SECONDS

echo "Waiting for openshift-gitops namespace to be created"
until oc get ns openshift-gitops
do
  sleep 5;
done

oc apply -k ./openshift-gitops

echo "Waiting for all pods to be created"
deployments (cluster kam openshift-gitops-applicationset-controller openshift-gitops-redis openshift-gitops-repo-server openshift-gitops-server)
for i in "${my_array[@]}";
do
  echo "Waiting for deployment $i";
  oc rollout status deployment $i
done

echo "Apply overlay to override default instance"
kustomize build | oc apply -f -

sleep 10
echo "Waiting for all pods to redeploy"
deployments (cluster kam openshift-gitops-applicationset-controller openshift-gitops-redis openshift-gitops-repo-server openshift-gitops-server)
for i in "${my_array[@]}";
do
  echo "Waiting for deployment $i";
  oc rollout status deployment $i
done

echo "GitOps Operator ready"
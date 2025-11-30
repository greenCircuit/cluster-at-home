#!/bin/bash
# getting helm chart for the repo, can comment out if already present
# https://artifacthub.io/packages/helm/open-webui/open-webui
# helm repo add open-webui https://helm.openwebui.com/
# helm repo update

# installing/upgrading chart and using just values that need
helm upgrade --install open-webui open-webui/open-webui -f open-webui-vals.yaml
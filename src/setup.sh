#!/bin/bash

install() {
    # kubectl
    echo "## Installing kubectl.."
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

    curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

    echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

    #heml
    echo "## Installing helm.."
    #curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh

    echo "## Installing gcloud.."
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

    sudo apt update && sudo apt install google-cloud-cli

    sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin
    #export USE_GKE_GCLOUD_AUTH_PLUGIN=True
}

case $1 in
  install)
    install
    ;;
  *)
    echo "Usage: $0 {install}"
    ;;
esac
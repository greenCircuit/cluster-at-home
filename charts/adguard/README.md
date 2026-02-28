# adguard-home

![Version: 5.5.2](https://img.shields.io/badge/Version-5.5.2-informational?style=flat-square) ![AppVersion: v0.107.7](https://img.shields.io/badge/AppVersion-v0.107.7-informational?style=flat-square)

DNS proxy as ad-blocker for local network

**This chart is not maintained by the upstream project and any issues with the chart should be raised [here](https://github.com/k8s-at-home/charts/issues/new/choose)**

## Source Code

* <https://github.com/AdguardTeam/AdGuardHome>

## Requirements

Kubernetes: `>=1.16.0-0`

# Values the default values are meant to run with tls and host network enabled. I enaled host network adguard known source ips. Without it 
k8s ip will be source up 
need to have tls enabled because dont want to expose http port

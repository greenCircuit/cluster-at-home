# About
Store collection of helm charts, yaml manifests that would use to create home lab k8s environment


### charts dir
Place where would put helm charts for home lab. Some of application have Docker image, but there is no way to deploy then inside k8s

- adguard: make adguard run inside cluster and make host to use as dns provider
- adguard-prometheus-exporter: scrape metrics from multiple adguard instances and make prometheus scrape it using service monitor CR
- kube-prometheus-stack-istio: made so kube prometheus stack is able to run with istio enabled, by default it doesn't work bc need to disable isto for job pods
- ollama-llm: attach gpu to a pod and run ollama + open webui
- psql-dump: cronjob that pg_dumps posql db and uploads it to some where


# my-cluster
- all things that need to run home k8s cluster
- use flux cd to bootsrap all resources
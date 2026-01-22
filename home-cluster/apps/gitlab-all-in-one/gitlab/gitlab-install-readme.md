# Purpose
Have self-hosted gitlab and gitlab runner running inside k8s cluster


# Table of contents
- Base values overlays
- Persistence
- Secrets
- Runner

## Base values overlays
Base values that I found found working best for me.

```yaml
global:
  edition: ce
  gitlabVersion: "18.3.5"
  hosts:
    domain: example.com   # match what will be domain of your instance. Without it will get 502 errors
    https: false          # need to have so can log in when using istio gateway otherwise get 502 error
  time_zone: EST
  ingress:
    enabled: false
  certmanager-issuer:
    email: email@example.com
  installCertmanager: true
  certmanager:
    installCRDs: false 
  nginx-ingress: &nginx-ingress
    enabled: false
  prometheus:
    install: false 
  registry:
    enabled: true 
  gitlab-runner:
    install: false
```


## Persistence configuration
Will need to create pv and pvs if you want to pe


## Creating gitlab k8s secrets


## Creating runner
```
runnerToken: ""
gitlabUrl: http://gitlab-gitlab-hr-webservice-default:8181/ # name of svc, host where gitlab
logLevel: info
rbac:
    create: true
    rules:
    - resources: ["events"]
        verbs: ["list", "watch"]
    - resources: ["pods"]
        verbs: ["create","delete","get"]
    - apiGroups: [""]
        resources: ["pods/attach","pods/exec"]
        verbs: ["get","create","patch","delete"]
    - apiGroups: [""]
        resources: ["pods/log"]
        verbs: ["get","list"]
    - resources: ["secrets"]
        verbs: ["create","delete","get","update"]
    - resources: ["serviceaccounts"]
        verbs: ["get"]
    - resources: ["services"]
        verbs: ["create","get"]

serviceAccount:
    create: true

runners:
    config: |
    concurrent = 5
    check_interval = 3
    log_level = "debug"
    log_format = "runner"
    connection_max_age = "15m0s"
    tls_verify = false
    [session_server]
        session_timeout = 1800
    [[runners]]
        url = "http://gitlab-gitlab-hr-webservice-default:8181"
        executor = "kubernetes"
        builds_dir = "/tmp"
        environment = ["HOME=/tmp"]
        shell = "bash"
        request_concurrency = 3
        limit = 5
        [runners.kubernetes]
        helper_image = "gitlab/gitlab-runner-helper:x86_64-v18.4.0"
        host = ""
        bearer_token_overwrite_allowed = false
        image = ""
        namespace = "gitlab"
        namespace_per_job = false
        privileged = true
        node_selector_overwrite_allowed = ".*"
        node_tolerations_overwrite_allowed = ""
        pod_labels_overwrite_allowed = ""
        service_account_overwrite_allowed = ""
        pod_annotations_overwrite_allowed = ""
        [runners.kubernetes.pod_labels]
            app = "gitlab-job"
        [runners.kubernetes.volumes]
            [[runners.kubernetes.volumes.empty_dir]]
            name = "repo"
            mount_path = "/tmp"
        [runners.kubernetes.pod_security_context]
            run_as_non_root = true
            run_as_user = 1000
        [runners.kubernetes.build_container_security_context]
            run_as_user = 1000
```
## Troubleshooting
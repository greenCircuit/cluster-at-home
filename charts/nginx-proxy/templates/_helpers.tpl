{{/* non-empty when any ports entry sets cookieGate */}}
{{- define "nginx-proxy.cookieGate" -}}
{{- range .Values.ports }}{{ if .cookieGate }}true{{ end }}{{ end }}
{{- end }}

{{/*
SA name: explicit name wins; create without name → app name; else none (pod uses ns default).
*/}}
{{- define "microservice.serviceAccountName" -}}
{{- if .Values.serviceAccount.name -}}
{{- .Values.serviceAccount.name -}}
{{- else if .Values.serviceAccount.create -}}
{{- .Values.name -}}
{{- end -}}
{{- end -}}

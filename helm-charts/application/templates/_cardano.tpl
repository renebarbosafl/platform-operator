{{/*
Defining a block for cardano socat sidecar
*/}}
{{- define "cardano.sidecar" -}}
- name: socat
  args:
  - UNIX-LISTEN:/ipc/node.socket,fork
  - TCP-CONNECT:cardano-node-{{ .network }}.vela-system:8090
  image: alpine/socat
  imagePullPolicy: Always
  volumeMounts:
  - mountPath: /ipc
    name: ipc
{{- end }}

{{/*
Defining a block for cardano config-cloner sidecar
*/}}
{{- define "cardano.configCloner" -}}
initContainers:
- args:
  - clone
  - --single-branch
  - --
  - https://github.com/input-output-hk/cardano-configurations
  - /node-config
  image: alpine/git
  imagePullPolicy: Always
  name: node-config-cloner
  volumeMounts:
  - mountPath: /node-config
    name: node-config
{{- end }}


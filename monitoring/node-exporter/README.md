# kubernetes-node-exporter
https://github.com/bibinwilson/kubernetes-node-exporter
https://devopscube.com/node-exporter-kubernetes/
https://devopscube.com/monitor-linux-servers-prometheus-node-exporter/

ashish@IN-4T24GK3:~/amway/k38-practice/monitoring$ k logs node-exporter-2rtg8 -n monitoring
Error from server (BadRequest): container "node-exporter" in pod "node-exporter-2rtg8" is waiting to start: CreateContainerError

$ k describe po node-exporter-2rtg8 -n monitoring

  Normal   Pulled     8m59s                   kubelet            Successfully pulled image "prom/node-exporter" in 1.927330952s (1.927354775s including waiting)
  Warning  Failed     8m59s                   kubelet            Error: failed to generate container "ec536fe5cf69f220fbbc6a6be58ebdfb57896aa0d3950f1306a3a3b57125a49e" spec: failed to generate spec: path "/sys" is mounted on "/sys" but it is not a shared or slave mount
  Normal   Pulled     5m37s (x12 over 8m25s)  kubelet            (combined from similar events): Successfully pulled image "prom/node-exporter" in 2.072984564s (2.073009453s including waiting)

  kubectl patch ds node-exporter --type "json" -p '[{"op": "remove", "path" : "/spec/template/spec/containers/0/volumeMounts/2/mountPropagation"}]' -n monitoring

  
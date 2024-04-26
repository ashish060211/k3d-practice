# Sample Application Deployment

The repository contains Kubernetes manifests that defines the deployment of the
[sample application](https://github.com/gitopsbook/sample-app).

To deploy the application manually run the following command:

```
kubectl create ns sample-app
kubectl apply -f . -n sample-app
```

To test the application run the command below and access http://localhost:8080/

```
kubectl port-forward svc/sample-app 8083:80
```

manifest definitions of every Argo CD component :- https://github.com/gitopsbook/resources

watch "kubectl get pods -n cj2 -l cj2job --sort-by=.metadata.creationTimestamp -o 'jsonpath={.items[-1].metadata.name}' | xargs kubectl logs -n cj2"

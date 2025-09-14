Perfeito, Davi! Aqui vai o **Markdown completo e unificado**, mantendo o fluxo original que você seguiu e incluindo **edição de deployment, service e components.yaml**, com destaque para o que precisa ser alterado. Tudo em **ordem cronológica correta**.

---

````markdown
# Guia Completo: Configuração Metrics Server + HPA no Kubernetes (Docker Desktop)

## 1. Aplicar componentes básicos do Metrics Server

### Editar `components.yaml` (se necessário)
- **Alterar porta HTTPS de 443 para 4443**
- **Adicionar argumento `--secure-port=4443`** no container do Metrics Server:
```yaml
args:
  - --cert-dir=/tmp
  - --secure-port=4443
  - --kubelet-insecure-tls
  - --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname
  - --metric-resolution=15s
````

### Aplicar os componentes

```bash
kubectl apply -f components.yaml
```

---

## 2. Verificar pods do Metrics Server

```bash
kubectl get pods -n kube-system | grep metrics-server
kubectl get pods -n kube-system -o wide
```

---

## 3. Editar deployment do Metrics Server

* Para **adicionar ou corrigir argumentos**:

```bash
kubectl edit deploy metrics-server -n kube-system
```

* Alterações importantes:

  * `--secure-port` → `4443`
  * `--kubelet-insecure-tls` → obrigatório no Docker Desktop
  * Certifique-se de manter:

```yaml
args:
  - --cert-dir=/tmp
  - --secure-port=4443
  - --kubelet-insecure-tls
  - --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname
  - --metric-resolution=15s
```

---

## 4. Editar service do Metrics Server

* Ajustar porta para `4443`:

```bash
kubectl edit svc metrics-server -n kube-system
```

* Alterar `ports` para:

```yaml
ports:
  - port: 4443
    targetPort: 4443
    protocol: TCP
    name: https
```

---

## 5. Reiniciar deployment para aplicar alterações

```bash
kubectl rollout restart deploy metrics-server -n kube-system
```

---

## 6. Verificar status do deployment

```bash
kubectl get deploy metrics-server -n kube-system
kubectl describe deploy metrics-server -n kube-system
```

---

## 7. Ver logs do Metrics Server

```bash
kubectl logs -n kube-system deploy/metrics-server
```

---

## 8. Testar métricas do cluster

* Métricas dos nodes:

```bash
kubectl top nodes
```

* Métricas dos pods (namespace default):

```bash
kubectl top pods -n default
```

---

## 9. Criar deployment de exemplo (nginx)

```bash
kubectl apply -f nginx-deployment.yaml
```

---

## 10. Criar service do nginx

```bash
kubectl apply -f nginx-service.yaml
```

---

## 11. Criar HPA para o nginx

```bash
kubectl apply -f nginx-hpa.yaml
```

---

## 12. Monitorar HPA

* Ver status do HPA:

```bash
kubectl get hpa
kubectl describe hpa nginx-hpa
```

* Monitoramento contínuo:

```bash
watch kubectl top pods
```

---

## 13. (Opcional) Ver detalhes do cluster

```bash
kubectl get nodes -o wide
kubectl get pods --all-namespaces
```

---

## Resumo das alterações importantes

| Arquivo / Recurso         | O que mudar                                                           |
| ------------------------- | ----------------------------------------------------------------------|
| components.yaml           | `--secure-port=4443` no args do container e containerPort recebe 4443 |
| deployment metrics-server | args: adicionar `--kubelet-insecure-tls`, checar `--secure-port`      |
| service metrics-server    | port e targetPort → `4443`                                            |

---
# React Tetris V1

Tetris game built with React

<h1 align="center">
  <img alt="React tetris " title="#React tetris desktop" src="./images/game.jpg" />
</h1>

**Deployment of Tetris game on Kubernetes and Automating it with argo-cd and terraform via jenkins Pipeline**

## Project Intoduction
we are going to deploy version of tetris game on aws EKS ckuster for this we are using terraform to create a base instance called the jenkins server and jenkins agent then from this intance we setup pipeline, which build docker image and push it to dockerhub than setup eks cluster and argo cd inside the cluster to deploy our application

## Completion steps
Step 1 → Setup Terraform and configure aws on your local machine

Step 2 → Building a Infrastructure from code using terraform

Step 3 → Setup Sonarqube , jenkins and jenkins agent 

Step 4 → ci-cd pipeline to build and push the image to docker hub

Step 5→ Update Image name In deployment repo

Step 6→ EKS cluster creation

Step 7→ Install Argo cd

Step 8 → [Deploy Application with ArgoCD](https://github.com/Omar-Ahmed-Dt/Tetris-deployment-file)

Step 9 → Destruction

---

**Step 1 → Setup Terraform and configure aws on your local machine**

<img src=images/aws_credentials.png>

---

**Step 2 → Building a Infrastructure from code using terraform**

<img src=images/ec2.png>

---

**Step 3 → Setup Sonarqube , jenkins and jenkins agent**

<img src=images/jenkins1.png>
<img src=images/jenkins2.png>
<img src=images/sonar.png>

---

**Step 4 → ci-cd pipeline to build and push the image to docker hub**

<img src=images/ci.png>
<img src=images/dockerhub.png>

---

**Step 5→ Update Image name In deployment repo**

<img src=images/update_name.png>

---

**Step 6→ EKS cluster creation**

<img src=images/eks.png>
<img src=images/eks2.png>

---

**Step 7→ Install Argo cd**

```
aws eks update-kubeconfig --region ap-south-1 --name EKS_CLOUD

snap install helm --classic

helm repo add argo-cd https://argoproj.github.io/argo-helm

helm repo update

kubectl create namespace argocd

helm install argocd argo-cd/argo-cd -n argocd

kubectl get all -n argocd

```

<img src=images/eks3.png>

```
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

snap install jq

export ARGOCD_SERVER=`kubectl get svc argocd-server -n argocd -o json | jq --raw-output '.status.loadBalancer.ingress[0].hostname'`

echo $ARGOCD_SERVER
```
<img src=images/eks4.png>
<img src=images/argo1.png>

```
username: admin
For Password: 
export ARGO_PWD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode)

echo $ARGO_PWD
```
---

**Step 8 → Deploy Application with ArgoCD**

<img src=images/argo2.png>
<img src=images/argo3.png>

---

**Step 9 → Destruction**

<img src=images/destroy.png>
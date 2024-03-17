# React Tetris V1

Tetris game built with React

<h1 align="center">
  <img alt="React tetris " title="#React tetris desktop" src="./images/game.jpg" />
</h1>

**Deployment of Tetris game on Kubernetes and Automating it with argo-cd and terraform via jenkins Pipeline**

## Project Intoduction
Today we are going to deploy version of tetris game on aws EKS ckuster for this we are using terraform to create a base instance called the jenkins server and jenkins agent then from this intance we setup pipeline, which build docker image and push it to dockerhub than setup eks cluster and argo cd inside the cluster to deploy our application

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














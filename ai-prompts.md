# AI Prompts

This file contains all prompts submitted during the development of this project.

## 1. Initialize CLAUDE.md

```
/init
```

## 2. Create Multi-Stage Dockerfile

```
we should create a multi stage docker file for the app here one for the build stage and next stage is production/release stage. we need to make sure we have NODE_ENV=production set up for the image, I expect this docker image to be run by non root user, we want it to be exposing a port as well. We want to keep alpine docker image as a base. Lets make Dockerfile production ready.
```

## 3. Support Migration in Docker Image

```
One more thing to note we expect the migration job to be run as a part of kubernetes pre-install and pre-upgrade job to create schema, so we need to make sure the docker image supports the app migration so docker image needs to be used to run migration too before the app starts the migration runs.
```

## 4. Kill Processes and Restart on Port 8087

```
search and kill everything running on port 8087 locally and docker 3000 we expect this app to run clean on 8087
```

## 5. Review Dockerfile Again

```
can we check if Dockerfile is good too.
```

## 6. Simplify Healthcheck

```
CMD ["node", "-e", "fetch('http://localhost:3000/').then(r => { if (!r.ok) throw r.status })"] do we need to use fetch and if throw errors, may be simple check if enough.?
```

## 7. Keep HTTP Check

```
no http check is fine if needed
```

## 8. Remove Pinned SHA Digest

```
FROM node:24-alpine@sha256:01743339035a5c3c11a373cd7c83aeab6ed1457b55da6a69e014a95ac4e4700b AS build
I don't want to pin to this SHA , use proper stable version
```

## 9. Create Helm Chart, Terraform, and Observability

```
In this repo we want to have have GKE terraform and some addons(mainly external secrets operator, otel-collector agent, cert manager, and argocd). We will house them in gcp as a core folder to keep the GKE cluster standard in europe region, then will add a folder gcp-addons in the terraform to house all addons post GKE cluster is available via this.
```

## 10. Same Observability Stack

```
we will use same tech stack for observability
```

## 11. Copied Scripts Folder

```
I have copied scripts folder to also initially create the bucket and terraform backend for this
```

## 12. Fix GCP Project ID

```
gcloud projects add-iam-policy-binding moonpay-devops-challenge does not have permission... I think the project id should be correct, check the project id to vg-moonpay-challenge and check
```

## 13. Enable GCP APIs

```
Error: googleapi: Error 403: Compute Engine API has not been used in project vg-moonpay-challenge before or it is disabled.
```

## 14. Docker Pull Secret Needed

```
we need to add docker secret in kubernetes to pull images.
Error: ImagePullBackOff
```

## 15. Migration Can't Reach Database

```
k logs -f crypto-prices-migrate-1-6hcc5
Error: P1001: Can't reach database server at crypto-prices-postgresql:5432
```

## 16. Migration Completed but App Errors

```
postgres \c currencies
\dt shows currencies table exists
so migration did complete, app seems doing something weird.
Error: The table public.currencies does not exist in the current database.
```

## 17. Define Expected Deployment Flow

```
so I expected the flow for this will always be that when you run helm upgrade --install we expect the helm chart deploy first the job to perform migration, hook should ensure that nothing starts before the postgres DB schema finishes. Next is to start the app. Now we expect that postgres is the one pod to start, then app gets started. Next is all the observability things like prometheus, loki and then grafana to start.
```

## 18. PostgreSQL Image Pull Error

```
crypto-prices-postgresql-0 0/1 ImagePullBackOff
```

## 19. Move Secrets to Secret Manager

```
we need to move secrets to secrets manager and let external secrets operator pull them
```

## 20. Successful Redeployment

```
when we try to re-deploy I see these errors
[pod lifecycle events showing successful rolling update]
```

## 21. ArgoCD Application Structure

```
wait but the crypto-prices app will be deployed via a separate folder we will create in here and we will define the application set and sync the app to cluster
```

## 22. Kustomize Base/Overlay for ArgoCD

```
no in argocd folder we need to specify the base folder that defines the app set with generator, so if we want to deploy to other regions etc, also we need crypto prices app to also have that and create folders like base and overlay and then overlay can induce the values into the base and use kustomize to model the rendered appset to deploy to argocd and sync from main branch.
```

## 23. ArgoCD System Ready

```
ok argocd-system is ready and nice. terraform is good
```

## 24. Browse ArgoCD UI

```
lets browse argo UI
```

## 25. ArgoCD App Path Error

```
ComparisonError
Failed to load target state: failed to generate manifest for source 1 of 1: rpc error: code = Unknown desc = helm/crypto-prices: app path does not exist
```

## 26. Check Gitignore and Dockerignore

```
can we check gitignore and dockerignore are set correctly
```

## 27. Create AI Prompts File

```
can we create ai-prompts.md file in the root of this repo, this markdown file should contain all the prompts I have asked and submitted.
```

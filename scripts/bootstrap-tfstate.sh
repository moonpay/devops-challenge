#!/usr/bin/env bash
set -euo pipefail

PROJECT_ID="${1:?Usage: $0 <project-id> [region]}"
REGION="${2:-europe-west2}"
BUCKET="${PROJECT_ID}-crypto-prices-tfstate"

if ! gcloud auth application-default print-access-token &>/dev/null; then
  echo "Terraform needs Application Default Credentials. Running:"
  echo "  gcloud auth application-default login"
  echo ""
  gcloud auth application-default login
fi

echo "Project:  $PROJECT_ID"
echo "Region:   $REGION"
echo "Bucket:   gs://$BUCKET"
echo ""

if gsutil ls -b "gs://$BUCKET" &>/dev/null; then
  echo "Bucket already exists, skipping creation."
else
  echo "Creating bucket..."
  gsutil mb -p "$PROJECT_ID" -l "$REGION" -b on "gs://$BUCKET"
  gsutil versioning set on "gs://$BUCKET"
  echo "Bucket created."
fi

echo ""
echo "Now run:"
echo "  cd terraform/gcp"
echo "  terraform init -backend-config=\"bucket=$BUCKET\""
echo ""
echo "  cd ../gcp-addon"
echo "  terraform init -backend-config=\"bucket=$BUCKET\""

# 1. Ensure Cloud Build API is enabled
resource "google_project_service" "cloudbuild_manual" {
  service            = "cloudbuild.googleapis.com"
  disable_on_destroy = false
}

# 2. Define a Manual Cloud Build Trigger
resource "google_cloudbuild_trigger" "manual_deploy_trigger" {
  name        = "${var.app_name}-manual-deploy"
  description = "Manual trigger for local source (No Git required)"

  source_to_build {
    uri       = "https://github.com/placeholder/placeholder" # Placeholder URI
    ref       = "refs/heads/main"
    repo_type = "GITHUB"
  }

  build {
    step {
      id   = "Build Image"
      name = "gcr.io/cloud-builders/docker"
      args = [
        "build",
        "--platform", "linux/amd64",
        "-t", "${var.region}-docker.pkg.dev/${var.project_id}/${var.app_name}-docker/${var.app_name}:latest",
        "."
      ]
    }

    step {
      id   = "Push Image"
      name = "gcr.io/cloud-builders/docker"
      args = ["push", "${var.region}-docker.pkg.dev/${var.project_id}/${var.app_name}-docker/${var.app_name}:latest"]
    }

    step {
      id         = "Deploy to Cloud Run"
      name       = "gcr.io/google.com/cloudsdktool/cloud-sdk"
      entrypoint = "gcloud"
      args = [
        "run", "services", "update", var.app_name,
        "--image", "${var.region}-docker.pkg.dev/${var.project_id}/${var.app_name}-docker/${var.app_name}:latest",
        "--region", var.region,
        "--port", "3000"
      ]
    }
    
    options {
      logging = "CLOUD_LOGGING_ONLY"
    }
  }

  substitutions = {
    _APP_NAME = var.app_name
    _REGION   = var.region
  }

  depends_on = [google_project_service.cloudbuild_manual]
}

output "manual_trigger_command" {
  value = "gcloud builds submit --config=cloudbuild.yaml ."
  description = "Run this from your terminal. It will upload your local files and execute the build."
}

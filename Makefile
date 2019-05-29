HASH := `git rev-parse --short HEAD`

SERVICE := next
PROJECT := triamudomcmc

IMAGE := gcr.io/$(PROJECT)/$(SERVICE):$(HASH)

docker:
	@echo "\n~> building docker image"
	@gcloud builds submit -t $(IMAGE)


deploy: next docker
	@echo "\n~> deploying $(SERVICE) to Cloud Run servers"
	@gcloud beta run deploy $(SERVICE) --allow-unauthenticated --region us-central1 --image $(IMAGE) --memory=512Mi
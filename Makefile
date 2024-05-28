install-docker:
	docker build -t workflow-python:latest -f docker/Dockerfile_Python .
	docker build -t workflow-r:latest -f docker/Dockerfile_R .
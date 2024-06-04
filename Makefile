install-docker:
	docker build -t mpc/protstatswf-python:1.0.0 -f docker/Dockerfile_Python .
	docker build -t mpc/protstatswf-r:1.0.0 -f docker/Dockerfile_R .
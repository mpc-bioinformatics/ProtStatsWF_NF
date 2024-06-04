install-docker:
	docker build -t mpc/ProtStatsWF-python:1.0.0 -f docker/Dockerfile_Python .
	docker build -t mpc/ProStatsWf-r:1.0.0 -f docker/Dockerfile_R .
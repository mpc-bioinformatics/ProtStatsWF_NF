# AMD64 needed explicitly on ARM as some sofwtare is only available in AMD64
FROM --platform=amd64 mambaorg/micromamba:1.5.1-jammy

WORKDIR /home/mambauser
# Copy backend and environment.yml
COPY --chown=mambauser:mambauser docker/environment.yml .
#COPY --chown=mambauser:mambauser docker/requirements.txt .

USER mambauser
ENV HOME /home/mambauser
ENV ENV_NAME=ProtStatsWF

RUN echo 'show_banner: false' > ~/.mambarc

RUN micromamba env create -y -f docker/environment.yml \
    && micromamba clean --all --yes

# RUN R -e "install protstatsWF"

USER root
# First is necessary for base_image to actvate the conda environment second is entrypoint
# which adds the python file to PATH
ENTRYPOINT [ "/usr/local/bin/_entrypoint.sh"]
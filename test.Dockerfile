# multi-stage building
FROM python:3.6-slim as cloner

SHELL ["/bin/bash", "-c"]

RUN apt-get update -qq && \
  apt-get install -y --no-install-recommends \
  git ssh

# add credentials on build
ARG SSH_PRIVATE_KEY
RUN mkdir /root/.ssh/
RUN echo "${SSH_PRIVATE_KEY}" > /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa

# make sure your domain is accepted
RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

RUN git clone git@github.com:jmrf/nlu-engine.git


FROM python:3.6-slim

COPY --from=cloner /nlu-engine /src/nlu-engine

# install the cloned-repo
RUN pip install -e /src/nlu-engine

RUN python3 -m rasa_nlu.train -h

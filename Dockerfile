# syntax=docker/dockerfile:1.4

# Use an official Python runtime as a parent image
FROM python:3.9.18-slim-bookworm  AS revenium-isotope-sandbox

ARG REVENIUM_API_KEY 

ARG DEBIAN_FRONTEND=noninteractive
ARG APT_LISTCHANGES_FRONTEND=none

RUN apt-get -qq update\
 && apt-get -qq install\
 curl\
 lsb-release\
 && apt-get -qq clean

ENV REVENIUM_API_KEY=$REVENIUM_API_KEY

COPY --link app/ /usr/src/app/
COPY --link --chmod=755 ./entrypoint /entrypoint
ENTRYPOINT ["/entrypoint"]

WORKDIR /usr/src/app
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000
ENV NAME EchoAPI

# Run app.py when the container launches
CMD ["python", "./app.py"]

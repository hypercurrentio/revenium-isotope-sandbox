# syntax=docker/dockerfile:1.4

FROM python:3.9.18-slim-bookworm  AS revenium-isotope-sandbox

ARG REVENIUM_API_KEY 

ARG DEBIAN_FRONTEND=noninteractive
ARG APT_LISTCHANGES_FRONTEND=none

RUN apt-get -qq update\
 && apt-get -qq install\
 curl\
 lsb-release\
 && apt-get -qq clean

# STEP 1: Propagate REVENIUM_API_KEY environment variable
ENV REVENIUM_API_KEY=$REVENIUM_API_KEY

# STEP 2: Copy Revenium entrypoint script
COPY --link --chmod=755 ./entrypoint /entrypoint 

# STEP 3: Define Revenium entrypoint and pass any custom isotope command line arguments
ENTRYPOINT ["/entrypoint"]

COPY --link app/ /usr/src/app/
WORKDIR /usr/src/app
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000
ENV NAME EchoAPI

# Run app.py when the container launches
CMD ["python", "./app.py"]

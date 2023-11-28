# syntax=docker/dockerfile:1.4

# Use an official Python runtime as a parent image
FROM python:3.8-slim AS rm-isotope-sandbox

ARG DEBIAN_FRONTEND=noninteractive
ARG APT_LISTCHANGES_FRONTEND=none
ARG RM_KEYRING_DIR=/usr/share/keyrings
ARG RM_KEYRING_FILE=rm-dev-archive-keyring.gpg
ARG RM_REPO_BASE=https://pkg.dev.hcapp.io/deb

RUN apt-get -qq update && apt-get -qq install\
 curl\
 lsb-release\
 gnupg\
 ;

RUN curl -o "${RM_KEYRING_DIR}/${RM_KEYRING_FILE}"\
 "${RM_REPO_BASE}/${RM_KEYRING_FILE}"

RUN echo "deb [signed-by=${RM_KEYRING_DIR}/${RM_KEYRING_FILE}]"\
 "${RM_REPO_BASE}/`lsb_release -is | tr A-Z a-z`/"\
 "`lsb_release -cs`" main > /etc/apt/sources.list.d/rm-dev.list

RUN apt-get -qq update && apt-get -qq install\
 isotope\
 isotope-ebpf-shim\
 ;

# Copy the current directory contents into the container at /usr/src/app
COPY --link app/ /usr/src/app/

# Set the working directory in the container
WORKDIR /usr/src/app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Define environment variable
ENV NAME EchoAPI

ENV ISOTOPE_API_KEY=your_default_api_key

CMD ["sh", "-c", "isotope --api-key $ISOTOPE_API_KEY other_parameters"]

# Run app.py when the container launches
CMD ["python", "./app.py"]

# Use an official Python runtime as a parent image
FROM python:3.8-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the current directory contents into the container at /usr/src/app
COPY . /usr/src/app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Define environment variable
ENV NAME EchoAPI

RUN apt-get update && apt-get install -y curl lsb-release gnupg 

RUN curl -o /usr/share/keyrings/rm-dev-archive-keyring.gpg https://pkg.dev.hcapp.io/deb/rm-dev-archive-keyring.gpg

RUN echo 'deb [signed-by=/usr/share/keyrings/rm-dev-archive-keyring.gpg]' \
    https://pkg.dev.hcapp.io/deb/`lsb_release -is | tr A-Z a-z`/ \
    `lsb_release -cs` main > /etc/apt/sources.list.d/rm-dev.list


RUN apt-get update && apt-get install -y isotope isotope-ebpf-shim

ENV ISOTOPE_API_KEY=your_default_api_key

CMD ["sh", "-c", "isotope --api-key $ISOTOPE_API_KEY other_parameters"]

# Run app.py when the container launches
CMD ["python", "./app.py"]

# syntax=docker/dockerfile:1.4

# Use an official Python runtime as a parent image
FROM python:3.8-slim AS rm-isotope-sandbox

# Copy the current directory contents into the container at /usr/src/app
COPY --link app/ /usr/src/app/

# Set the working directory in the container
WORKDIR /usr/src/app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

RUN apt-get update && apt-get install -y curl lsb-release

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Define environment variable
ENV NAME EchoAPI

# Run app.py when the container launches
CMD ["python", "./app.py"]

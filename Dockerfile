FROM ghcr.io/huggingface/text-generation-inference:1.1.0 AS base

# Set work directory
WORKDIR /usr/src/app

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV model $model

# Install dependencies
RUN pip install --upgrade pip
RUN pip install runpod text-generation

# Update and install supervisor
RUN apt-get update && apt-get install -y supervisor

# Copy supervisor configuration
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Copy project
COPY . /usr/src/app

# Set permissions
RUN chmod +x /usr/src/app/entrypoint.sh

# Expose the required port
EXPOSE 8080

# Run the app
ENTRYPOINT ["/bin/bash", "/usr/src/app/entrypoint.sh"]
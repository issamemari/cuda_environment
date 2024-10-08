# Use an NVIDIA base image with CUDA support
FROM nvidia/cuda:12.4.1-cudnn-devel-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install Python 3.9
RUN apt-get update && apt-get install -y python3.9 python3.9-dev python3.9-distutils && \
    apt-get install -y python3-pip git && \
    rm -rf /var/lib/apt/lists/* && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3.9 1

# Install Hugging Face transformers
RUN pip install transformers
# (Optional) Copy project files
COPY . /app
WORKDIR /app

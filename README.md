# Dockerized CUDA Environment for Training Transformers

This repository provides a Docker container for setting up a CUDA-enabled environment that supports GPU acceleration and the Hugging Face Transformers library, specifically for training large language models (LLMs).

## How to Test the Docker Image

The pre-built Docker image is hosted on AWS ECR. To pull and run the image, follow these steps:

### Pull the image
```
docker pull public.ecr.aws/n4t8b6w0/huggingface/cuda_environment:latest
```

### Run the Demo Script

To verify that CUDA is properly set up, run the following command:

```
docker run --rm public.ecr.aws/n4t8b6w0/huggingface/cuda_environment python /app/src/demo.py
```

If the machine has a CUDA-capable GPU, the output should read: `CUDA available: True`. If not, it will output: `CUDA available: False`.

### Build the Image Locally

You can also build the image from the Dockerfile in the repository with:

```
docker build -t cuda_environment .
```

Then you can similarly run it with:

```
docker run --rm cuda_environment python /app/src/demo.py
```

## Continuous Integration (CI)

This repository is set up with a GitHub Actions workflow that automatically builds and publishes the Docker image with every push. Each image is tagged with both the commit SHA and the latest tag for easy reference.

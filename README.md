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

This repository is configured with a GitHub Actions workflow that automatically builds and publishes the Docker image with each push. Every image is tagged with both the commit SHA and the latest tag for easy reference.

If you want to publish the Docker image to your own AWS ECR registry, you can fork this repository and configure the necessary GitHub secrets as follows:

* ECR_REGISTRY: The URI of your ECR registry (e.g., public.ecr.aws/your-repository).
* AWS_ACCESS_KEY_ID: Your AWS access key ID for authenticating with AWS services.
* AWS_SECRET_ACCESS_KEY: The secret access key associated with your AWS account.
* AWS_REGION: The AWS region where your ECR registry is located (e.g., us-east-1).

Make sure these secrets are set up properly in your GitHub repository for the workflow to function as expected.

## Manually Publishing the Docker Image to Your Own AWS ECR Registry

This repository includes a GitHub Actions workflow that automatically builds and publishes Docker images to AWS ECR on every push.

However, if you want to manually build and publish the image, you can follow these steps:

### Install AWS CLI

Ensure that the AWS CLI is installed on your local machine. You can install it by following the instructions [here](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).

### Create an ECR Repository

If you don't already have an ECR repository, you'll need to create one. Instructions for creating a private repository can be found in the AWS documentation [here](https://docs.aws.amazon.com/AmazonECR/latest/userguide/repository-create.html). You can also create a public repository by following the instructions [here](https://docs.aws.amazon.com/AmazonECR/latest/public/public-repository-create.html).

Once created, take note of the repository URI, which you will use in the following steps.

### Configure AWS Credentials

Once the AWS CLI is installed, configure your AWS credentials using the following command:

```
aws configure
```

You will be prompted to enter your AWS credentials (Access Key ID, Secret Access Key, Region, etc.). These credentials are required to authenticate and push the Docker image to ECR.

### Login to Amazon ECR

After configuring your AWS credentials, log in to your ECR repository using the AWS CLI:

#### Public Repository
```
aws ecr-public get-login-password --region <your-region> | docker login --username AWS --password-stdin <your-repository-uri>
```

#### Private Repository
```
aws ecr get-login-password --region <your-region> | docker login --username AWS --password-stdin <your-repository-uri>
```

### Build the Docker Image

Build the Docker image using both the commit SHA and latest tag:

```
ECR_REGISTRY=<your-repository-uri>
ECR_IMAGE_NAME=huggingface/cuda_environment

docker build -t $ECR_REGISTRY/$ECR_IMAGE_NAME:latest .
```

### Push the Docker Image

```
docker push $ECR_REGISTRY/$ECR_IMAGE_NAME:latest
```

This process will publish both an image tagged latest to the public ECR registry.

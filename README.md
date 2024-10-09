# Dockerized CUDA environment for training Transformers

This repository provides a Docker container that sets up an environment supporting CUDA for GPU acceleration and the Hugging Face Transformers library for training LLMs.

## Testing the image

The image is currently hosted on a public container registry (ECR from AWS), you can pull it and run it as follows:

Pull the image
```
docker pull public.ecr.aws/n4t8b6w0/huggingface/cuda_environment:latest
```

Run the demo script

```
docker run --rm public.ecr.aws/n4t8b6w0/huggingface/cuda_environment python /app/src/demo.py
```

If you are on a machine that has a CUDA-capable GPU, this should print something like `CUDA available: True`, otherwise it should output `CUDA available: False`

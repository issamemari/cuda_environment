import torch


def main():
    print("CUDA available: ", torch.cuda.is_available())


if __name__ == "__main__":
    main()

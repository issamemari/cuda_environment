import torch


def main():
    print(f"CUDA available: {torch.cuda.is_available()}")


if __name__ == "__main__":
    main()

# Installation

This guide explains how to download, verify, and set up the CUDA-enabled `llama.cpp` executable on Ubuntu 22.04.

## 1. Download the release
1. Open the repository's **Releases** page in your browser.
2. Download the latest `llama-cpp-cuda-ubuntu-22.04.tar.xz` asset.

If you prefer the terminal, replace `<OWNER>` with the GitHub account name that hosts this repository:
```bash
REPO_URL="https://github.com/<OWNER>/Ubuntu-Cuda-Llama.cpp-Executable"
curl -LO "$REPO_URL/releases/latest/download/llama-cpp-cuda-ubuntu-22.04.tar.xz"
```

## 2. Verify the checksum (recommended)
1. Calculate the SHA-256 checksum locally:
   ```bash
   sha256sum llama-cpp-cuda-ubuntu-22.04.tar.xz
   ```
2. Compare the output to the checksum published alongside the release. Only proceed if they match.

## 3. Extract the archive
```bash
tar -xvf llama-cpp-cuda-ubuntu-22.04.tar.xz
```

This creates a `bin/` directory with the `llama-cpp` executable.

## 4. Make the binary executable
```bash
chmod +x bin/llama-cpp
```

Optionally move `bin/` somewhere in your `PATH`:
```bash
sudo mv bin/llama-cpp /usr/local/bin/
```

## 5. Test the installation
Display the built-in help to confirm the binary runs:
```bash
llama-cpp -h
```

You are now ready to run inference. Continue to the [usage guide](usage.md) for command examples and CUDA tuning flags.

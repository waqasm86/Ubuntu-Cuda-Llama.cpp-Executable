# Ubuntu CUDA llama.cpp Executable

Prebuilt `llama.cpp` binary for Ubuntu 22.04 with CUDA acceleration. This repository documents the executable, explains how to download it from GitHub Releases, and captures the build configuration used to target NVIDIA GPUs on Ubuntu systems.

## Project goals
- Provide a ready-to-run `llama.cpp` binary compiled with the CUDA (cuBLAS) backend for Ubuntu 22.04.
- Offer clear installation, verification, and usage instructions for running inference on NVIDIA GPUs.
- Keep reproducible build notes so the binary can be rebuilt locally if needed.

## System requirements
- Ubuntu 22.04 (x86_64).
- NVIDIA GPU with CUDA-capable drivers installed.
- Sufficient VRAM for the model you plan to run (quantized 7B models typically fit in 8–12 GB).
- Basic terminal utilities: `curl`, `tar`, and `sha256sum`.

## Download and install
1. Navigate to the repository's **Releases** page and download the latest `llama-cpp-cuda-ubuntu-22.04.tar.xz` artifact.
2. Extract the archive:
   ```bash
   tar -xvf llama-cpp-cuda-ubuntu-22.04.tar.xz
   ```
3. Move the extracted `bin/` directory to a convenient location (for example, your home directory) and ensure the executable is marked as runnable:
   ```bash
   chmod +x bin/llama-cpp
   ```

See [`docs/installation.md`](docs/installation.md) for detailed installation and verification steps.

## Quick start
Run a quantized model with the CUDA-enabled executable after extraction:
```bash
# Set CUDA to target your desired GPU (optional)
export CUDA_VISIBLE_DEVICES=0

# Run inference (example assumes a 7B Q4_K_M model)
./bin/llama-cpp \
  -m models/llama-2-7b.Q4_K_M.gguf \
  -p "What is llama.cpp?" \
  -n 128
```

More usage patterns, GPU flags, and performance tips are documented in [`docs/usage.md`](docs/usage.md).

## Repository structure
- `README.md` – project overview, requirements, and quick start.
- `bin/` – location for the CUDA-enabled `llama.cpp` executable (populated from the release archive). See [`bin/README.md`](bin/README.md) for layout details.
- `docs/` – supplementary documentation:
  - [`installation.md`](docs/installation.md) – download, extraction, and checksum verification.
  - [`usage.md`](docs/usage.md) – command examples and CUDA tuning flags.
  - [`build-notes.md`](docs/build-notes.md) – reproducible build configuration used to create the binary.

## Support and feedback
If you encounter issues with the binary or documentation, please open a GitHub issue with your environment details (GPU model, driver version, CUDA version) and the command you ran. Contributions to improve the docs are welcome.

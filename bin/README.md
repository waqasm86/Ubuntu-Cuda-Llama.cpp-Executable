# `bin/` directory

This folder is where the CUDA-enabled `llama.cpp` executable lives after extracting a release or copying a locally built binary.

## Expected contents
- `llama-cpp` – the CUDA/cuBLAS-enabled executable built from the upstream `llama.cpp` project.

The binary itself is **not** committed to source control. Download it from the GitHub release archive (`llama-cpp-cuda-ubuntu-22.04.tar.xz`) or build it yourself using the steps in [`docs/build-notes.md`](../docs/build-notes.md).

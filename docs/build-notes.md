# Build notes

These notes capture the general configuration used to produce the CUDA-enabled `llama.cpp` executable for Ubuntu 22.04. You can follow the same steps to rebuild locally or adjust flags for your hardware.

## Prerequisites
- CMake 3.22 or newer
- A C++17 compiler (e.g., `g++` on Ubuntu 22.04)
- CUDA Toolkit (matching the driver installed on your system)
- Git (to clone the upstream `llama.cpp` repository)

## Build steps
1. Clone upstream `llama.cpp`:
   ```bash
   git clone https://github.com/ggerganov/llama.cpp.git
   cd llama.cpp
   ```
2. Configure with CMake enabling cuBLAS:
   ```bash
   cmake -B build \
     -DCMAKE_BUILD_TYPE=Release \
     -DLLAMA_CUBLAS=ON
   ```
3. Compile:
   ```bash
   cmake --build build -j$(nproc)
   ```
4. Copy the resulting executable into `bin/` in this repository:
   ```bash
   cp build/bin/llama-cli /path/to/Ubuntu-Cuda-Llama.cpp-Executable/bin/llama-cpp
   ```

> Note: The exact target name may differ slightly depending on upstream changes (for example, `llama-cli` vs `llama-cpp`). Ensure you copy the CUDA-enabled binary from the build output.

## Recommended strip and packaging
- Strip symbols to reduce size (optional):
  ```bash
  strip bin/llama-cpp
  ```
- Package the binary for release:
  ```bash
  tar -cJvf llama-cpp-cuda-ubuntu-22.04.tar.xz bin/
  ```

## Reproducibility tips
- Record the upstream `llama.cpp` commit hash in your release notes.
- Document the CUDA toolkit and driver versions used during the build.
- Include the `sha256sum` of the packaged archive with each release to help users verify downloads.

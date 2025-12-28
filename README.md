# Ubuntu CUDA llama.cpp Executable - Pre-Built Binary for Ubuntu 22.04

Pre-built **llama.cpp** CUDA binary for Ubuntu 22.04 (x86_64) with NVIDIA GPU support.

**No compilation required** - download, extract, and run! Tested on GeForce 940M (1GB VRAM) to RTX 4090.

[![Download](https://img.shields.io/github/downloads/waqasm86/Ubuntu-Cuda-Llama.cpp-Executable/total)](https://github.com/waqasm86/Ubuntu-Cuda-Llama.cpp-Executable/releases)
[![Release](https://img.shields.io/github/v/release/waqasm86/Ubuntu-Cuda-Llama.cpp-Executable)](https://github.com/waqasm86/Ubuntu-Cuda-Llama.cpp-Executable/releases/latest)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

> **Keywords**: llama.cpp ubuntu binary, pre-built llama.cpp, llama server ubuntu, cuda binary, gguf inference, no compilation, GeForce 940M, JupyterLab integration

## 📦 What's Included

- **llama-server** - HTTP server for LLM inference (primary executable)
- **llama-cli** - Command-line interface for direct inference
- **llama-bench** - Benchmarking tool
- All supporting libraries and CUDA binaries

**Build**: llama.cpp commit `10b4f82d4` (build 7489)
**CUDA**: Built with CUDA 12.8 support
**Updated**: December 28, 2025

## ⚡ Quick Start

### Step 1: Download and Extract

```bash
# Download the binary (check latest release)
wget https://github.com/waqasm86/Ubuntu-Cuda-Llama.cpp-Executable/releases/latest/download/llama.cpp-ubuntu-cuda-x64.tar.xz

# Extract
tar -xf llama.cpp-ubuntu-cuda-x64.tar.xz

# Enter the directory
cd llama-cpp-cuda

# Verify CUDA support
./bin/llama-server --version
```

**Expected output:**
```
ggml_cuda_init: found 1 CUDA devices:
  Device 0: NVIDIA GeForce 940M, compute capability 5.0, VMM: yes
version: 7489 (10b4f82d4)
```

### Step 2: Download a GGUF Model

Download a small model for testing:

```bash
# Download Gemma 3 1B (Q4_K_M quantization, ~700 MB)
cd bin
wget https://huggingface.co/google/gemma-3-1b-it-GGUF/resolve/main/gemma-3-1b-it-Q4_K_M.gguf
cd ..
```

Or use any GGUF model from HuggingFace and place it in the `bin/` folder.

### Step 3A: Command-Line Usage (Manual Server)

```bash
# Start llama-server with the model
./bin/llama-server \
  -m ./bin/gemma-3-1b-it-Q4_K_M.gguf \
  --port 8090 \
  -ngl 8 \
  -c 512
```

Then access the web UI at: `http://localhost:8090`

### Step 3B: Python/JupyterLab Usage (Recommended)

For automatic server management and Python API, use **[llcuda](https://github.com/waqasm86/llcuda)**:

**Installation:**
```bash
# Install llcuda from PyPI
pip install llcuda
```

**Usage in JupyterLab or Python:**

```python
import os

# Set the path to llama-server
pwd = '/home/waqasm86/Downloads/llama-cpp-cuda'  # Your extraction path
os.environ['LLAMA_SERVER_PATH'] = pwd + '/bin/llama-server'

# Import llcuda
import llcuda

# Verify
print(f"LLAMA_SERVER_PATH: {os.environ.get('LLAMA_SERVER_PATH')}")
print(f"llcuda version: {llcuda.__version__}")

# Create inference engine
engine = llcuda.InferenceEngine()

# Load model with optimized settings for GeForce 940M (1GB VRAM)
engine.load_model(
    pwd + "/bin/gemma-3-1b-it-Q4_K_M.gguf",
    auto_start=True,     # Automatically starts llama-server
    gpu_layers=8,        # 8 layers on GPU
    ctx_size=512,        # Small context to save memory
    n_parallel=1,        # Single sequence
    verbose=True,
    batch_size=512,      # Reduces from default 2048
    ubatch_size=128,     # CRITICAL - reduces compute buffer
)

print("\n✓ Model loaded successfully!")

# Run inference
result = engine.infer("What is AI?", max_tokens=100)

# Display result
if result.success:
    print("\n" + "="*60)
    print("Generated Text:")
    print("="*60)
    print(result.text)
    print("="*60)
    print(f"\nPerformance:")
    print(f"  Tokens: {result.tokens_generated}")
    print(f"  Speed: {result.tokens_per_sec:.1f} tok/s")
    print(f"  Latency: {result.latency_ms:.0f}ms")
else:
    print(f"Error: {result.error_message}")
```

**Expected output:**
```
✓ Model loaded and ready for inference
✓ Model loaded successfully!

============================================================
Generated Text:
============================================================
AI, or Artificial Intelligence, is essentially the ability of a
computer or machine to perform tasks that typically require human
intelligence...
============================================================

Performance:
  Tokens: 100
  Speed: 12.2 tok/s
  Latency: 8217ms
```

**llcuda features**:
- ✅ Automatic server management (no manual startup!)
- ✅ Auto-discovery of models and executables
- ✅ JupyterLab integration
- ✅ Performance metrics
- ✅ Context manager support

**Learn more**: [llcuda on PyPI](https://pypi.org/project/llcuda/) | [llcuda on GitHub](https://github.com/waqasm86/llcuda)

## 📋 System Requirements

### Minimum
- Ubuntu 22.04 (x86_64)
- NVIDIA GPU with CUDA 5.0+ compute capability
- 1GB+ VRAM (tested on GeForce 940M)
- CUDA 11.7+ or 12.x runtime
- NVIDIA driver 525+

### Verified Working On
- ✅ GeForce 940M (1GB VRAM) - 12-15 tok/s with Gemma 3 1B
- ✅ RTX series (larger models, higher throughput)
- ✅ Ubuntu 22.04 with CUDA 12.8

## 🚀 Performance

Tested with **Gemma 3 1B Q4_K_M** on GeForce 940M (1GB VRAM):

```bash
./bin/llama-server -m gemma-3-1b-it-Q4_K_M.gguf -ngl 8 -c 512 -ub 128
```

**Results**:
- **Speed**: 12.8 tokens/second
- **GPU Layers**: 8 out of 27
- **Memory**: ~350 MB VRAM used

## 📖 What's Inside

```
llama.cpp-733c851f-bin-ubuntu-cuda/
├── bin/
│   ├── llama-server          # HTTP server (main executable)
│   ├── llama-cli             # CLI interface
│   ├── llama-bench           # Benchmarking
│   ├── llama-quantize        # Model quantization
│   ├── llama-perplexity      # Perplexity calculation
│   └── ... (other utilities)
└── lib/
    ├── libggml-cuda.so       # CUDA backend
    ├── libggml-base.so       # GGML base library
    └── ... (supporting libraries)
```

## 🔧 Environment Setup

Add to your `~/.bashrc`:

```bash
export LLAMA_CPP_DIR="/path/to/llama.cpp-733c851f-bin-ubuntu-cuda"
export LD_LIBRARY_PATH="$LLAMA_CPP_DIR/lib:${LD_LIBRARY_PATH}"
export PATH="$LLAMA_CPP_DIR/bin:$PATH"
```

Then:
```bash
source ~/.bashrc
llama-server --version
```

## 📥 Download

**Latest Release**: [v0.1.0](https://github.com/waqasm86/Ubuntu-Cuda-Llama.cpp-Executable/releases/tag/v0.1.0)

**File**: `llama.cpp-733c851f-bin-ubuntu-cuda-x64.tar.xz` (290 MB)

**SHA256 Checksum**: (add if available)

## 🤝 Related Projects

- **[llcuda](https://github.com/waqasm86/llcuda)** - Python wrapper for this binary (recommended!)
- **[llama.cpp](https://github.com/ggerganov/llama.cpp)** - Original project

## 📄 License

Same as llama.cpp - MIT License

## 🙏 Credits

Built from [llama.cpp](https://github.com/ggerganov/llama.cpp) commit `733c851f`

## 📞 Support

For issues with:
- **This binary**: Open an issue in this repository
- **llcuda Python package**: See [llcuda issues](https://github.com/waqasm86/llcuda/issues)
- **llama.cpp itself**: See [llama.cpp issues](https://github.com/ggerganov/llama.cpp/issues)

---

**Built for easy CUDA-accelerated LLM inference on Ubuntu** 🚀

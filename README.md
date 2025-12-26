# Ubuntu CUDA llama.cpp Executable

Pre-built **llama.cpp** CUDA binary for Ubuntu 22.04 (x86_64) with NVIDIA GPU support.

**No compilation required** - download, extract, and run!

## 📦 What's Included

- **llama-server** - HTTP server for LLM inference (primary executable)
- **llama-cli** - Command-line interface for direct inference
- **llama-bench** - Benchmarking tool
- All supporting libraries and CUDA binaries

**Build**: llama.cpp commit `733c851f` (build 6093)
**CUDA**: Built with CUDA 12.x support
**Size**: 290 MB compressed

## ⚡ Quick Start

### Download and Extract

```bash
# Download the binary
wget https://github.com/waqasm86/Ubuntu-Cuda-Llama.cpp-Executable/releases/download/v0.1.0/llama.cpp-733c851f-bin-ubuntu-cuda-x64.tar.xz

# Extract
tar -xf llama.cpp-733c851f-bin-ubuntu-cuda-x64.tar.xz
cd llama.cpp-733c851f-bin-ubuntu-cuda

# Verify it works
./bin/llama-server --version
```

### Basic Usage

```bash
# Start llama-server with a GGUF model
./bin/llama-server \
  -m /path/to/your/model.gguf \
  --port 8090 \
  -ngl 99 \
  -c 2048
```

Then access at: `http://localhost:8090`

## 🐍 Use with Python (llcuda)

For a Python API wrapper with automatic server management, use **[llcuda](https://github.com/waqasm86/llcuda)**:

```bash
# Set environment variable
export LLAMA_SERVER_PATH=$PWD/bin/llama-server

# Install llcuda
pip install llcuda
```

Then use in Python:
```python
import llcuda

engine = llcuda.InferenceEngine()
engine.load_model(
    "/path/to/model.gguf",
    auto_start=True,  # Automatically starts llama-server
    gpu_layers=99
)

result = engine.infer("What is AI?", max_tokens=100)
print(result.text)
```

**llcuda features**:
- Automatic server management (no manual startup!)
- Auto-discovery of models and executables
- JupyterLab integration
- Performance metrics
- Context manager support

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

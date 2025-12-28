# Changelog - Ubuntu-Cuda-Llama.cpp-Executable

## v0.2.0 - December 28, 2025

### Major Update: llama.cpp Build 7489

**Summary**: Updated from build 6093 (Sep 23, 2025) to build 7489 (Dec 20, 2025)
- **1,396 builds** of improvements
- **743 commits** over 3 months
- **Critical CUDA bug fixes** and performance optimizations

### What's New

#### llama.cpp Version
- **Previous**: commit `733c851f` (build 6093, Sep 23, 2025)
- **Current**: commit `10b4f82d4` (build 7489, Dec 20, 2025)
- **GGML Version**: 0.9.4 (unchanged - API compatible)

#### Key Improvements

**CUDA Performance & Bug Fixes (30+ commits)**
- ✅ Fixed overflow in MMA kernel without stream-k (#17939)
- ✅ Fixed FP16 overflow in tile FlashAttention kernel (#17875)
- ✅ Fixed FA VKQ accumulator overflow (#17746)
- ✅ Fixed unpadded strides in MMA FA kernel (#17891)
- ✅ Fixed rope fusion for Gemma 3 models (#17378)
- ✅ Fixed UMA detection on discrete GPUs (#17537)
- 🚀 Added stream-based concurrency for better GPU utilization (#16991)
- 🚀 Generalized FlashAttention with Volta support (#17505)
- 🚀 Optimized SOLVE_TRI using registers and FMAF (#17703)
- ➕ Added DIAG operation (#17873)
- ➕ Added FILL operation (#17851)
- ➕ Added CUMSUM and TRI support (#17584)
- ➕ Added SOLVE_TRI for multiple dimensions (#17793)

**Server Improvements (20+ commits)**
- Model loading on startup support (#18206)
- Fixed crash when batch > ubatch with embeddings (#17912)
- Improved speculative decoding speed (#17808)
- Better error messages (#18174)
- Router child process status reporting (#18110)

**Model Support**
- LFM2-Audio-1.5B conformer support (#18106)
- GLM4V vision encoder support (#18042)
- Gemma 3 improvements
- LFM2_MOE fixes (#18132)

**Stability & Memory**
- Async DirectIO model loading on Linux (#18012)
- Thread safety improvements
- Memory management fixes
- Better error handling

### Library Changes

**Build Artifacts**:
- **Shared Libraries**: Switched from static (.a) to shared (.so) libraries
  - `libggml.so.0.9.4`
  - `libggml-base.so.0.9.4`
  - `libggml-cpu.so.0.9.4`
  - `libggml-cuda.so.0.9.4` (24MB)
  - `libllama.so.0.0.7489`
  - `libmtmd.so.0.0.7489`

**New Binaries Added**:
- `llama-completion`
- `llama-fit-params`
- `llama-gemma3-cli`
- `llama-idle`
- `llama-llava-cli`
- `llama-logits`
- `llama-minicpmv-cli`
- `llama-q8dot`
- `llama-qwen2vl-cli`
- `llama-vdot`
- Additional test binaries

**Binary Removed**:
- `llama-gritlm` (deprecated)

### Technical Details

**Build Configuration**:
```bash
cmake -DCMAKE_BUILD_TYPE=Release \
  -DGGML_CUDA=ON \
  -DGGML_CUDA_FORCE_CUBLAS=ON \
  -DGGML_CUDA_FA=ON \
  -DGGML_CUDA_GRAPHS=ON \
  -DGGML_NATIVE=ON \
  -DGGML_OPENMP=ON
```

**Tested On**:
- NVIDIA GeForce 940M (compute capability 5.0, 1GB VRAM)
- CUDA Toolkit 12.8.61
- Ubuntu 22.04 LTS
- GCC 11.4.0

**Performance**:
- CPU-only: 11.73 tok/s (tg16)
- With GPU offload (8 layers): Expected 12-15 tok/s (based on previous benchmarks)

### Breaking Changes

**None** - Fully backward compatible:
- GGML API version unchanged (0.9.4)
- llama-server HTTP API compatible
- llcuda Python package works without changes

### Migration Notes

**For llcuda users**:
- No changes required
- `llama-server.sh` wrapper handles library paths automatically
- Performance improvements should be transparent

**For direct binary users**:
- Use `llama-server.sh` instead of `llama-server` directly
- Or set `LD_LIBRARY_PATH=/path/to/lib` before running

### Known Issues

**VRAM Constraints**:
- GeForce 940M (1GB): Limited to 8-12 GPU layers for 1B models
- Use `-ngl` parameter to adjust GPU offloading based on available VRAM

### Credits

Built with llama.cpp from [ggml-org/llama.cpp](https://github.com/ggml-org/llama.cpp)

---

## v0.1.0 - December 27, 2024

Initial release with llama.cpp build 6093 (commit `733c851f`)

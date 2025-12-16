# Usage

The CUDA-enabled `llama.cpp` binary supports the same flags as upstream `llama.cpp` with additional performance considerations for NVIDIA GPUs.

## Basic inference
After extracting the release archive and placing the executable on your `PATH` (or running from `bin/`), run a prompt with:
```bash
./bin/llama-cpp \
  -m models/llama-2-7b.Q4_K_M.gguf \
  -p "Explain llama.cpp in two sentences." \
  -n 128
```

### Selecting a GPU
Set `CUDA_VISIBLE_DEVICES` to target a specific GPU:
```bash
CUDA_VISIBLE_DEVICES=1 ./bin/llama-cpp -m models/llama-2-7b.Q4_K_M.gguf -p "Hello" -n 32
```

### Batch and context settings
- `-n <tokens>` controls the number of new tokens to generate.
- `-c <ctx>` sets context length; larger contexts require more VRAM.
- `-b <batch>` adjusts batch size; experiment to maximize GPU utilization without exhausting memory.

## GPU performance flags
Common CUDA-related options:
- `--gpu-layers <N>`: number of layers to offload to the GPU (use `-1` to offload all layers when memory allows).
- `--tensor-split`: split work across multiple GPUs (comma-separated ratios, e.g., `--tensor-split 0.5,0.5`).
- `--flash-attn`: enable Flash Attention if supported by the build and your GPU.
- `--parallel`: allow speculative decoding when supported by the model.

## Prompt file example
Provide a prompt from a file instead of the `-p` flag:
```bash
./bin/llama-cpp \
  -m models/llama-2-7b.Q4_K_M.gguf \
  --file prompts/story.txt \
  -n 200
```

## Streaming output
Add `-s` for sampling seed consistency and `-i` to enable interactive mode (type while it generates):
```bash
./bin/llama-cpp -m models/llama-2-7b.Q4_K_M.gguf -i -s 1234
```

## Troubleshooting
- **`CUDA error` on start:** ensure the NVIDIA driver and CUDA runtime installed on your system match the version used to build the binary.
- **`out of memory`**: lower `--gpu-layers`, reduce `-b`, or use a more heavily quantized model.
- **Slow generation:** try increasing `-b`, enable `--flash-attn` if available, or reduce the `-p` prompt length.

For build-time options and reproducibility notes, see [`build-notes.md`](build-notes.md).

#!/usr/bin/env bash
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export LD_LIBRARY_PATH="$HERE/../lib:${LD_LIBRARY_PATH:-}"
exec "$HERE/llama-server" "$@"

#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
SOURCE_CONFIG="${REPO_ROOT}/config/lazygit/config.yml"

if [[ ! -f "${SOURCE_CONFIG}" ]]; then
  echo "Missing source config: ${SOURCE_CONFIG}" >&2
  exit 1
fi

if ! command -v lazygit >/dev/null 2>&1; then
  echo "lazygit is not installed or not in PATH." >&2
  exit 1
fi

TARGET_DIR="$(lazygit -cd)"
TARGET_CONFIG="${TARGET_DIR}/config.yml"

mkdir -p "${TARGET_DIR}"
ln -sfn "${SOURCE_CONFIG}" "${TARGET_CONFIG}"

echo "Linked ${TARGET_CONFIG} -> ${SOURCE_CONFIG}"

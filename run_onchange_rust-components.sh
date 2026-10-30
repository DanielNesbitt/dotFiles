#!/bin/bash

set -eo pipefail

# rust-analyzer is installed as a rustup component so it matches the toolchain
# it analyses. Skipped where rustup has no toolchain yet (e.g. a fresh install).
if command -v rustup >/dev/null 2>&1 && rustup show active-toolchain >/dev/null 2>&1; then
    rustup component add rust-analyzer rust-src
fi

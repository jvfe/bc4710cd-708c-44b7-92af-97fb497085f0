#!/usr/bin/env bash
set -euo pipefail

docker run --rm \
    -v "$(pwd)":/app \
    -w /app \
    r-analysis-env \
    bash -c "Rscript plot.R"
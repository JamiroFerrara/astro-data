#!/usr/bin/env bash

MODREV=$(git describe --tags --always --first-parent | tr -d "v")
luarocks install "plenary.nvim" "$MODREV"

# Signed Polar Decomposition — Deterministic Paper Build
![CI](https://github.com/sontric/signed-polar-decomposition/actions/workflows/build-paper.yml/badge.svg)

This repo builds figures and a PDF **deterministically** using a pinned Nix dev shell.

## System requirements

- **Operating system:** Linux (NixOS recommended) or macOS.  
  *Windows users can build via WSL2 with Nix installed.*
- **Nix package manager:** `>= 2.18`, with flakes enabled.  
- **Disk space:** ~2 GB free for Nix store and dependencies.  
- **Optional:** [VSCodium](https://vscodium.com/) (or VS Code) for editing inside the dev shell.  

Everything else — compilers, LaTeX engine, Python/SymPy, etc. — is pinned by the flake to ensure **bit-for-bit reproducibility**.

## Quick start

```bash
# clone the repo
git clone https://github.com/sontric/signed-polar-decomposition

# enter shell with exact tools
nix develop

# open IDE from that dev shell env
# to edit, examine, or contribute
codium .

# generate PDF
make pdf
```

“Every paper is a trust capsule: bit-for-bit reproducible, timestamped, and signed.”
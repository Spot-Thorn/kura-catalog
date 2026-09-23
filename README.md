# kura-catalog

[![validate](https://github.com/Spot-Thorn/kura-catalog/actions/workflows/validate.yml/badge.svg?branch=main)](https://github.com/Spot-Thorn/kura-catalog/actions/workflows/validate.yml)

## Adding this source

In Kura, open **Sources** (top right), **Add**, and paste:

https://raw.githubusercontent.com/Spot-Thorn/kura-catalog/main/catalog.toml


The source is added **disabled**. Enable it, then hit **Refresh** — Kura downloads
the catalog and every script it names, and caches them so they keep working offline.

To pin to a fixed version, use a tag instead of `main`:
`.../kura-catalog/v1.0.0/catalog.toml`

## Actions

| Action | Category | Admin | Destructive |
| --- | --- | :-: | :-: |
| Fix Network Adapters (24H2) | troubleshoot | yes | yes |

## Before you enable this

Adding a source means running whatever this repo publishes, on your machines, as
administrator. Every script here is plain text in `Scripts/` — read the ones you
plan to run. CI checks that the catalog parses, that every script it names exists,
that no script tries to self-elevate, and that PSScriptAnalyzer reports no errors.

## Layout

- `catalog.toml` — action definitions, at the repo root
- `scripts/` — flat folder of `.ps1` files, no subfolders

## License

MIT — see [LICENSE](LICENSE).

# PullMD on Railway

[PullMD](https://github.com/AeternaLabsHQ/pullmd) (AGPL-3.0): a self-hosted URL/file → Markdown service for humans and AI agents. Web pages (with a headless-browser fallback), PDFs and Office files, YouTube transcripts and more become clean Markdown with stable share links, over a web UI, a REST + SSE API and an MCP endpoint. Deploy it on Railway with one click.

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/deploy/zObg3u)

## What this template runs
| Service | Image | Role |
|---|---|---|
| **pullmd** (public) | `ghcr.io/onepush-dev/pullmd:3.21.0` (official `aeternalabshq/pullmd:3.21.0`, app unmodified) | Web UI, API and MCP on port 8080; volume `/data` (SQLite cache, history, users). Health check `/api/status`. |
| **trafilatura** (private) | `aeternalabshq/pullmd-trafilatura:3.21.0` | Article/content extraction sidecar (:8001). |
| **playwright** (private) | `aeternalabshq/pullmd-playwright:3.21.0` | Headless Chromium for JavaScript-heavy pages (:8002). |
| **markitdown** (private) | `aeternalabshq/pullmd-markitdown:3.21.0` | PDF/Office/YouTube converter (:8003). |

## Variables (pullmd service)
| Variable | Value |
|---|---|
| `PULLMD_ADMIN_PASSWORD` | `${{secret(24)}}`: password for the admin account `admin@pullmd.local` (created on first boot) |
| `OAUTH_JWT_SECRET` | `${{secret(48)}}`: enables OAuth 2.1 for MCP clients (claude.ai web connector, Claude Desktop) |
| `PUBLIC_URL` | `https://${{RAILWAY_PUBLIC_DOMAIN}}` |
| `TRAFILATURA_URL` / `PLAYWRIGHT_URL` / `MARKITDOWN_URL` | `http://${{<sidecar>.RAILWAY_PRIVATE_DOMAIN}}:<port>/extract`, `/render`, `/convert` |

Baked defaults: `PULLMD_AUTH_MODE=single-admin`, `PULLMD_ADMIN_EMAIL=admin@pullmd.local`, `DISABLE_PUBLIC_HISTORY=true`, `PULLMD_TRUST_PROXY=1`, `CACHE_DB=/data/cache.db`.

Upstream ships with authentication **off**; this template turns it on so a public Railway URL is not an open converter. Sign in with `admin@pullmd.local` and `PULLMD_ADMIN_PASSWORD`, then create `pmd_` API keys under Settings for scripts and agents. Optional: `PULLMD_VISION_*`, `PULLMD_STT_*`, `PULLMD_LLM_*`, `PULLMD_PDF_OCR_*` keys for image captions, audio transcription and OCR; `PULLMD_AUTH_MODE=multi-user` for self-signup. Full reference: https://github.com/AeternaLabsHQ/pullmd#readme

Not affiliated with PullMD or Aeterna Labs.

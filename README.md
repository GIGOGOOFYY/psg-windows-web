# PSG Windows — deploy with GitHub + Cloudflare Pages (keys via env)

The Supabase URL + anon key are **injected at build time** from environment
variables set in Cloudflare Pages — they are never committed to Git.

## Files
- `index.html`  – the app. Contains placeholders `__SUPABASE_URL__` and `__SUPABASE_ANON_KEY__`.
- `build.sh`    – replaces the placeholders with env vars, writing `dist/index.html`.
- `.gitignore`  – ignores `.env` and `dist/`.
- `.env.example`– template; the real secrets live in the Cloudflare dashboard.

## One-time setup
1. Create a GitHub repo and push these files.
2. Cloudflare dashboard → **Workers & Pages → Create → Pages → Connect to Git** → pick the repo.
3. Build settings:
   - **Build command:** `bash build.sh`
   - **Build output directory:** `dist`
4. **Settings → Environment variables → add** (Production *and* Preview):
   - `SUPABASE_URL`  = your Project URL
   - `SUPABASE_ANON_KEY` = your anon public key
5. **Save and Deploy.** Every `git push` now rebuilds and injects the keys automatically.

## Update the app later
Just edit `index.html`, commit, and push — Cloudflare rebuilds on its own.

## Note
The anon key is public by design (it reaches the browser on the live site).
Keeping it in env only keeps it out of your Git history. Real access control =
Supabase Auth + Row-Level Security.

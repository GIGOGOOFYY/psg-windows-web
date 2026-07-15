#!/usr/bin/env bash
# Cloudflare Pages runs this at deploy. It injects the Supabase env vars
# (set in the Pages dashboard, NOT committed) into the built file.
set -e
mkdir -p dist
sed -e "s|__SUPABASE_URL__|${SUPABASE_URL}|g" \
    -e "s|__SUPABASE_ANON_KEY__|${SUPABASE_ANON_KEY}|g" \
    index.html > dist/index.html
echo "Built dist/index.html with Supabase env injected."

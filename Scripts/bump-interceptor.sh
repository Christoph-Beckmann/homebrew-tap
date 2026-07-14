#!/usr/bin/env bash
# Bump Casks/interceptor-browser.rb to the latest upstream GitHub release.
# Called from .update (before `brew upgrade --cask`) or manually.
set -euo pipefail

TAP_DIR="$(cd "$(dirname "$0")/.." && pwd)"
CASK="$TAP_DIR/Casks/interceptor-browser.rb"
REPO="Hacker-Valley-Media/Interceptor"

latest=$(curl -fsSL "https://api.github.com/repos/$REPO/releases/latest" |
  sed -n 's/.*"tag_name": *"v\{0,1\}\([^"]*\)".*/\1/p' | head -1)
current=$(sed -n 's/.*version "\(.*\)".*/\1/p' "$CASK" | head -1)

if [[ -z "$latest" ]]; then
  echo "interceptor-browser: could not determine latest release (API/network?)" >&2
  exit 1
fi

if [[ "$latest" == "$current" ]]; then
  echo "interceptor-browser: up-to-date ($current)"
  exit 0
fi

echo "interceptor-browser: $current -> $latest"
tmp=$(mktemp)
trap 'rm -f "$tmp"' EXIT
curl -fsSL -o "$tmp" \
  "https://github.com/$REPO/releases/download/v$latest/Interceptor-Browser-$latest.pkg"
sha=$(shasum -a 256 "$tmp" | awk '{print $1}')

sed -i '' \
  -e "s/version \"$current\"/version \"$latest\"/" \
  -e "s/sha256 \"[a-f0-9]*\"/sha256 \"$sha\"/" "$CASK"

git -C "$TAP_DIR" commit -am "interceptor-browser $latest" >/dev/null
git -C "$TAP_DIR" push >/dev/null 2>&1 ||
  echo "  (push failed - commit is local, will sync next run)"
echo "interceptor-browser: cask bumped to $latest - the following brew upgrade picks it up"

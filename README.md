# homebrew-tap

Personal Homebrew tap. Hosts cask recipes for tools that have no official
Homebrew distribution, so `brew bundle` can restore them on any machine.

## Usage

```sh
brew tap christoph-beckmann/tap
brew install --cask interceptor-browser
```

## Casks

| Cask | Upstream | Notes |
|------|----------|-------|
| `interceptor-browser` | [Hacker-Valley-Media/Interceptor](https://github.com/Hacker-Valley-Media/Interceptor) | Official signed `.pkg`, browser-only install (CLI + daemon + Chrome extension, no macOS bridge) |

## Updating

`Scripts/bump-interceptor.sh` checks the latest upstream release, rewrites
version + sha256 in the cask, commits and pushes. It is wired into the
`.update` shell routine; `brew upgrade --cask` then installs the new version.

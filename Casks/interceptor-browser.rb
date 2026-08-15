cask "interceptor-browser" do
  version "0.23.18"
  sha256 "622d318ef8924bcfe0943d3f6e072f5642222923c0c3105f75a730b3bae9a30a"

  url "https://github.com/Hacker-Valley-Media/Interceptor/releases/download/v#{version}/Interceptor-Browser-#{version}.pkg"
  name "Interceptor Browser"
  desc "Real-browser automation: CLI, daemon and Chrome extension (browser-only install, no macOS bridge)"
  homepage "https://github.com/Hacker-Valley-Media/Interceptor"

  livecheck do
    url :url
    strategy :github_latest
  end

  pkg "Interceptor-Browser-#{version}.pkg"

  uninstall pkgutil: [
    "com.interceptor.cli.pkg",
    "com.interceptor.daemon.pkg",
    "com.interceptor.extension.pkg",
  ]

  zap trash: [
    "~/.config/interceptor",
  ]

  caveats <<~EOS
    The Chrome extension is installed to:
      /Library/Application Support/Interceptor/extension
    Load it once via chrome://extensions -> Developer Mode -> "Load unpacked".
  EOS
end

cask "interceptor-browser" do
  version "2.1.3"
  sha256 "ca78debc4e4248ed4310b5f0683f8389d208e1d35546d5e91170379451c28628"

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

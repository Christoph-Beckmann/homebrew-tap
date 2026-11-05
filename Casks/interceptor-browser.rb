cask "interceptor-browser" do
  version "2.1.11"
  sha256 "047f47a9fbd2a270d04a511d9fc509a63f59c3c40fb8b2bba42b9219575c3383"

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

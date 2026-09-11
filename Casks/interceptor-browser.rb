cask "interceptor-browser" do
  version "0.24.13"
  sha256 "ef54041e777e7481be08b902faaffcc3ef2438effdb8e279647a3c78e2210094"

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

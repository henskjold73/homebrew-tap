cask "tspad" do
  version "0.9.0-beta.5"
  sha256 "d2534ca84fcec13b975173a2c41eafc155a485f4c6a70ce26cf5c080b9046e9d"

  url "https://github.com/henskjold73/tspad-beta/releases/download/v#{version}/TsPad-#{version}-arm64.dmg"
  name "TsPad"
  desc "LINQPad for TypeScript: query data sources with typed TypeScript"
  homepage "https://github.com/henskjold73/tspad-beta"

  livecheck do
    skip "Updated by TsPad's release script"
  end

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "TsPad.app"

  # Beta builds are not signed or notarized yet (no Apple Developer account), so macOS would refuse to open them.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/TsPad.app"]
  end

  # The data folder keeps the product's earlier name.
  zap trash: "~/Library/Application Support/TypePad"
end

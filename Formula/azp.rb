class Azp < Formula
  desc "Manage multiple Azure CLI logins, one config dir per profile"
  homepage "https://github.com/henskjold73/azp"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/henskjold73/azp/releases/download/v0.1.1/azp-aarch64-apple-darwin.tar.xz"
      sha256 "73c1b840138a55f804cd390feb7665d6a42621c0a6ff34f7b7caaf7796798b8e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/henskjold73/azp/releases/download/v0.1.1/azp-x86_64-apple-darwin.tar.xz"
      sha256 "e8cded1b0c7bcedde53dd8290b01a5443df970210e268156141a69c657f294dc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/henskjold73/azp/releases/download/v0.1.1/azp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a571faac36c9fa7fb0afccf9874f2fa588752511895957501be4feac7fbab0e0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/henskjold73/azp/releases/download/v0.1.1/azp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e08251bcae2dc2dbed7f07b4b177462229cbf5197d31b36678a557d5329587f9"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "azp"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "azp"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "azp"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "azp"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

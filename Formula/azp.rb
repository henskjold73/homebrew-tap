class Azp < Formula
  desc "Manage multiple Azure CLI logins, one config dir per profile"
  homepage "https://github.com/henskjold73/azp"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/henskjold73/azp/releases/download/v0.1.2/azp-aarch64-apple-darwin.tar.xz"
      sha256 "ca2969af690df53540562324a2d60249c1bdbc0e2988ac2959a1bf91fd48a999"
    end
    if Hardware::CPU.intel?
      url "https://github.com/henskjold73/azp/releases/download/v0.1.2/azp-x86_64-apple-darwin.tar.xz"
      sha256 "0176fcdc2d943adae1cc9fe12dab40b645b49405fc225b4e05734fdb26778888"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/henskjold73/azp/releases/download/v0.1.2/azp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "43a011cde7ed081d9e13fa4875a60bac765e923c0bc96cbf2b95c3a64aa785dd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/henskjold73/azp/releases/download/v0.1.2/azp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b190a32d76b847ccd1815195780008ba6e171e671ed11cd0c730f81695afed7b"
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

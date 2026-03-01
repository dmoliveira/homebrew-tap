class Sk < Formula
  desc "Minimal macOS Keychain CLI for storing and retrieving secrets by key"
  homepage "https://github.com/dmoliveira/sk"
  url "https://github.com/dmoliveira/sk/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "79d47b8a379c73655b9770298b35bcc821c9a25c6358ed3ef06006fe1c6c35e9"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: ".")
  end

  test do
    assert_match "sk", shell_output("#{bin}/sk --version")
  end
end

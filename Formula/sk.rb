class Sk < Formula
  desc "Minimal macOS Keychain CLI for storing and retrieving secrets by key"
  homepage "https://github.com/dmoliveira/sk"
  url "https://github.com/dmoliveira/sk/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "f13590b1948879245949426065e414870ab85bb417f7adb791584ea7253bb9f8"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: ".")
  end

  test do
    assert_match "sk", shell_output("#{bin}/sk --version")
  end
end

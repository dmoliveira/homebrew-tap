class Sk < Formula
  desc "Minimal macOS Keychain CLI for storing and retrieving secrets by key"
  homepage "https://github.com/dmoliveira/sk"
  url "https://github.com/dmoliveira/sk/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "17684acd7d1e51165183043bb956762e84b28c9e3516dc0498a1bb5314ea0e77"
  license "MIT"

  def install
    bin.install "sk"
  end

  test do
    assert_match "sk", shell_output("#{bin}/sk --version")
  end
end

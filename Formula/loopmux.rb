class Loopmux < Formula
  desc "Loop prompts into tmux panes with triggers and delays"
  homepage "https://github.com/dmoliveira/loopmux"
  url "https://github.com/dmoliveira/loopmux/archive/refs/tags/v0.1.12.tar.gz"
  sha256 "a63109b387136b1a803af30b05232f6861e82f70a79fb8bbbf7b9eba3c78080a"
  license "MIT"

  depends_on "rust" => :build

  def install
    ENV["CARGO_PROFILE_RELEASE_STRIP"] = "false"
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "loopmux", shell_output("#{bin}/loopmux --help")
  end
end

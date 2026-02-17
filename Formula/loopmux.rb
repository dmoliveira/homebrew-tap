class Loopmux < Formula
  desc "Loop prompts into tmux panes with triggers and delays"
  homepage "https://github.com/dmoliveira/loopmux"
  url "https://github.com/dmoliveira/loopmux/archive/refs/tags/v0.1.19.tar.gz"
  sha256 "79211154ce0d8a1a341bcfaa5ad4bda1a892284ca28a5c31bb027eb0dfbd13e2"
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

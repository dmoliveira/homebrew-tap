class Loopmux < Formula
  desc "Loop prompts into tmux panes with triggers and delays"
  homepage "https://github.com/dmoliveira/loopmux"
  url "https://github.com/dmoliveira/loopmux/archive/refs/tags/v0.1.24.tar.gz"
  sha256 "378cb123b62954571f581d5419dda8867d9f3e2f9ca128ae6900403b2b8a2219"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "loopmux", shell_output("#{bin}/loopmux --help")
  end
end

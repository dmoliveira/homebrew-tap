class Loopmux < Formula
  desc "Loop prompts into tmux panes with triggers and delays"
  homepage "https://github.com/dmoliveira/loopmux"
  url "https://github.com/dmoliveira/loopmux/archive/refs/tags/v0.1.9.tar.gz"
  sha256 "2d95a45734c3709eeb089537561bf3743371deb8c45101c40cb735b74248dd84"
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

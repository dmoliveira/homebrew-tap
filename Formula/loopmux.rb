class Loopmux < Formula
  desc "Loop prompts into tmux panes with triggers and delays"
  homepage "https://github.com/dmoliveira/loopmux"
  url "https://github.com/dmoliveira/loopmux/archive/refs/tags/v0.1.22.tar.gz"
  sha256 "dbfb1a657ca5e08850ee3a3385168b60b91b4a585377482caf386568a0424cfc"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "loopmux", shell_output("#{bin}/loopmux --help")
  end
end

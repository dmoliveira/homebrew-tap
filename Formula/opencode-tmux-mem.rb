class OpencodeTmuxMem < Formula
  desc "Inspect OpenCode memory and map PIDs to tmux panes"
  homepage "https://github.com/dmoliveira/opencode-tmux-mem"
  url "https://github.com/dmoliveira/opencode-tmux-mem/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "dbe7b26e91373a3f614274a556e39ddb5d78893171c3ac663c265b8e80daaf88"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/opencode-tmux-mem --help")
  end
end

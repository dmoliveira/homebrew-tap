class Loopmux < Formula
  desc "Loop prompts into tmux panes with triggers and delays"
  homepage "https://github.com/dmoliveira/loopmux"
  url "https://github.com/dmoliveira/loopmux/archive/refs/tags/v0.1.11.tar.gz"
  sha256 "f1fcc3c684bd8ab8d789881b909c377c4931f62faabffa47ec1743ec31d2c5e7"
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

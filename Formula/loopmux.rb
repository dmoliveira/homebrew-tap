class Loopmux < Formula
  desc "Loop prompts into tmux panes with triggers and delays"
  homepage "https://github.com/dmoliveira/loopmux"
  url "https://github.com/dmoliveira/loopmux/archive/refs/tags/v0.1.6.tar.gz"
  sha256 "7486e428a76c9116c57105560eeb7752358056b392c961ed5b1f8c5cfc06d08d"
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

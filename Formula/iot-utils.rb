class IotUtils < Formula
  desc "Safety-first Arduino and ESP32 verify/upload helper powered by arduino-cli"
  homepage "https://github.com/dmoliveira/iot-utils"
  url "https://github.com/dmoliveira/iot-utils/archive/refs/tags/v0.2.2.tar.gz"
  sha256 "66598a9ec5b28454fdc417b1b3843e97288611b70443e7ce53faa8e6ea023af7"
  license "Apache-2.0"

  depends_on "arduino-cli"
  depends_on "python@3.13"

  def install
    libexec.install "iot-utils", "iot-utils.json"
    chmod 0755, libexec/"iot-utils"
    (bin/"iot-utils").write_env_script libexec/"iot-utils", PATH: "#{Formula["arduino-cli"].opt_bin}:#{Formula["python@3.13"].opt_bin}:#{ENV["PATH"]}"
  end

  test do
    assert_match "No saved default port is configured", shell_output("#{bin}/iot-utils port show")
  end
end

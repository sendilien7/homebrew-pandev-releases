# Formula: pandev-cli-plugin.rb
=begin
After release, update the version and hashes. To get the new hashes run:

curl -sL https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.0.10/pandev-cli-plugin_1.0.10_macOS_amd64.tar.gz | shasum -a 256
curl -sL https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.0.10/pandev-cli-plugin_1.0.10_macOS_arm64.tar.gz | shasum -a 256
curl -sL https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.0.10/pandev-cli-plugin_1.0.10_Linux_amd64.tar.gz | shasum -a 256
=end

class PandevCliPlugin < Formula
  desc "Pandev CLI Plugin"
  homepage "https://github.com/sendilien7/homebrew-pandev-releases"
  version "1.0.10"

  depends_on "jq"
  depends_on "git"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v#{version}/pandev-cli-plugin_#{version}_macOS_amd64.tar.gz"
      sha256 "0f9c3c4e40fc40783e5d73811881b45aeefe8287235aa8c1aeb15c1b66166afd"
    else
      url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v#{version}/pandev-cli-plugin_#{version}_macOS_arm64.tar.gz"
      sha256 "f22814875b6bbd4ef626e27c2f54322165de96724ec3a8c075664bed4b4068f9"
    end
  end

  on_linux do
    url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v#{version}/pandev-cli-plugin_#{version}_Linux_amd64.tar.gz"
    sha256 "83687f1077a5e60a0f3e4b6ad9d3cdefbf8a674aa9edc8b99a74d0372fbee292"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/pandev"
    bin.install_symlink libexec/"bin/pandev-cli-plugin"
  end

  def post_install
    ohai "post_install: Starting..."
    debug_file = "#{ENV['HOME']}/.pandev_post_install_debug.log"
    ohai "after debug_file..."
    File.write(debug_file, "--- post_install ran at: #{Time.now} ---\n", mode: "a")

    install_command = ["#{bin}/pandev-cli-plugin", "--install"]
    ohai "post_install: Running: #{install_command.join(' ')}"

    # Use Open3 to capture stdout, stderr, and the status
    require "open3"
    stdout, stderr, status = Open3.capture3(*install_command)

    # Log everything for debugging
    File.write(debug_file, "STDOUT:\n#{stdout}\n", mode: "a")
    File.write(debug_file, "STDERR:\n#{stderr}\n", mode: "a")
    File.write(debug_file, "Exit Status: #{status.exitstatus}\n", mode: "a")

    # Homebrew's post_install fails if the block raises an exception.
    # We use `odie` to fail with a clear message including the stderr.
    unless status.success?
      odie <<~EOS
        The pandev-cli-plugin installer failed with an exit code of #{status.exitstatus}.
        Error details have been logged to: #{debug_file}
        STDERR:
        #{stderr}
      EOS
    end

    ohai "post_install: Successfully completed!"
  end

  def pre_uninstall
    system "#{bin}/pandev-cli-plugin", "--uninstall"
  end

  test do
    assert_match "version", shell_output("#{bin}/pandev status")
  end
end
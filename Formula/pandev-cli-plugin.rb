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
    ohai "post_install: Binary = #{bin}/pandev-cli-plugin"
    ohai "post_install: Exists = #{File.exist?("#{bin}/pandev-cli-plugin")}"

    require "open3"
    stdout, stderr, status = Open3.capture3("#{bin}/pandev-cli-plugin", "--install")

    ohai "post_install: Exit code = #{status.exitstatus}"
    ohai "post_install: STDOUT = #{stdout[0..200]}" unless stdout.empty?
    ohai "post_install: STDERR = #{stderr[0..200]}" unless stderr.empty?

    opoo "pandev-cli-plugin --install failed" unless status.success?
    ohai "post_install: Done!"
  end

  def pre_uninstall
    system "#{bin}/pandev-cli-plugin", "--uninstall"
  end

  test do
    assert_match "version", shell_output("#{bin}/pandev status")
  end
end
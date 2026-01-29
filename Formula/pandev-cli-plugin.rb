# Formula: pandev-cli-plugin.rb
=begin
After release, update the version and hashes. To get the new hashes run:

curl -sL https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.0.13/pandev-cli-plugin_1.0.13_macOS_amd64.tar.gz | shasum -a 256
curl -sL https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.0.13/pandev-cli-plugin_1.0.13_macOS_arm64.tar.gz | shasum -a 256
curl -sL https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.0.13/pandev-cli-plugin_1.0.13_Linux_amd64.tar.gz | shasum -a 256
=end

class PandevCliPlugin < Formula
  desc "Pandev CLI Plugin"
  homepage "https://github.com/sendilien7/homebrew-pandev-releases"
  version "1.0.13"

  depends_on "jq"
  depends_on "git"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v#{version}/pandev-cli-plugin_#{version}_macOS_amd64.tar.gz"
      sha256 "fa77cf202fe786d7ad745195227e55028fd889f7cee5446e74d212809d33e0f9"
    else
      url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v#{version}/pandev-cli-plugin_#{version}_macOS_arm64.tar.gz"
      sha256 "75b6fcaa48c6c837534905eab8763900fccc46913a5ba7a81b039079b2c770e8"
    end
  end

  on_linux do
    url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v#{version}/pandev-cli-plugin_#{version}_Linux_amd64.tar.gz"
    sha256 "6bf93d6992df6eb8c0a9075a698c38552e0b1a59365a6d2f562b7814e0c89364"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/pandev"
    bin.install_symlink libexec/"bin/pandev-cli-plugin"
  end

#   def post_install
#     ohai "post_install: Starting..."
#     ohai "post_install: Binary = #{bin}/pandev-cli-plugin"
#     ohai "post_install: Exists = #{File.exist?("#{bin}/pandev-cli-plugin")}"
#
#     require "open3"
#     stdout, stderr, status = Open3.capture3("#{bin}/pandev-cli-plugin", "--install")
#
#     ohai "post_install: Exit code = #{status.exitstatus}"
#     ohai "post_install: STDOUT = #{stdout[0..200]}" unless stdout.empty?
#     ohai "post_install: STDERR = #{stderr[0..200]}" unless stderr.empty?
#
#     opoo "pandev-cli-plugin --install failed" unless status.success?
#     ohai "post_install: Done!"
#   end

#   def pre_uninstall
#     system "#{bin}/pandev-cli-plugin", "--uninstall"
#   end

  test do
    assert_match "version", shell_output("#{bin}/pandev status")
  end
end
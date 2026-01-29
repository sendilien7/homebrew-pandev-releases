# Formula: pandev-cli-plugin.rb
=begin
After release, update the version and hashes. To get the new hashes run:

curl -sL https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.0.17/pandev-cli-plugin_1.0.17_macOS_amd64.tar.gz | shasum -a 256
curl -sL https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.0.17/pandev-cli-plugin_1.0.17_macOS_arm64.tar.gz | shasum -a 256
curl -sL https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.0.17/pandev-cli-plugin_1.0.17_Linux_amd64.tar.gz | shasum -a 256
=end

class PandevCliPlugin < Formula
  desc "Pandev CLI Plugin"
  homepage "https://github.com/sendilien7/homebrew-pandev-releases"
  version "1.0.17"

  depends_on "jq"
  depends_on "git"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v#{version}/pandev-cli-plugin_#{version}_macOS_amd64.tar.gz"
      sha256 "a684515802c4b4c694166fb01bb58719ce34421e4eb7160d5d04598e0747a63c"
    else
      url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v#{version}/pandev-cli-plugin_#{version}_macOS_arm64.tar.gz"
      sha256 "1871f9a0042fa7c2f80a54a318edba90dc69a76c7e1204e47b2b6dd998e5aaa6"
    end
  end

  on_linux do
    url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v#{version}/pandev-cli-plugin_#{version}_Linux_amd64.tar.gz"
    sha256 "32d5ef7db110b381479870e9c2654785328b94cce849aaf83e115b5ffc28cb63"
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
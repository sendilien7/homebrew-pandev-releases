# Formula: pandev-cli-plugin.rb
=begin
After release, update the version and hashes. To get the new hashes run:

curl -sL https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.0.15/pandev-cli-plugin_1.0.15_macOS_amd64.tar.gz | shasum -a 256
curl -sL https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.0.15/pandev-cli-plugin_1.0.15_macOS_arm64.tar.gz | shasum -a 256
curl -sL https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.0.15/pandev-cli-plugin_1.0.15_Linux_amd64.tar.gz | shasum -a 256
=end

class PandevCliPlugin < Formula
  desc "Pandev CLI Plugin"
  homepage "https://github.com/sendilien7/homebrew-pandev-releases"
  version "1.0.15"

  depends_on "jq"
  depends_on "git"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v#{version}/pandev-cli-plugin_#{version}_macOS_amd64.tar.gz"
      sha256 "ecd2c3aa3fde16c354c399c0c97a103c560aeb625c4407d80215fe4a9982a2e4"
    else
      url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v#{version}/pandev-cli-plugin_#{version}_macOS_arm64.tar.gz"
      sha256 "d707c2aa7792b23c893a64be62be38f5c2430f83c4e6446cc52078441abb15f0"
    end
  end

  on_linux do
    url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v#{version}/pandev-cli-plugin_#{version}_Linux_amd64.tar.gz"
    sha256 "d639b2e5731f40f52ca285c25865899c8ea6844882c3e14553879afa6f4cf419"
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
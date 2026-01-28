# Formula: pandev-cli-plugin.rb
=begin
After release, update the version and hashes. To get the new hashes run:

curl -sL https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.0.11/pandev-cli-plugin_1.0.11_macOS_amd64.tar.gz | shasum -a 256
curl -sL https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.0.11/pandev-cli-plugin_1.0.11_macOS_arm64.tar.gz | shasum -a 256
curl -sL https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.0.11/pandev-cli-plugin_1.0.11_Linux_amd64.tar.gz | shasum -a 256
=end

class PandevCliPlugin < Formula
  desc "Pandev CLI Plugin"
  homepage "https://github.com/sendilien7/homebrew-pandev-releases"
  version "1.0.11"

  depends_on "jq"
  depends_on "git"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v#{version}/pandev-cli-plugin_#{version}_macOS_amd64.tar.gz"
      sha256 "83656670d75fdbce61cf6e4c8418d870aadfa437aa21c20288e596d6c40789d9"
    else
      url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v#{version}/pandev-cli-plugin_#{version}_macOS_arm64.tar.gz"
      sha256 "ca2ba307dd0b875f6d021cefcf7d47a229713fbf8e82713214e0128a058e90aa"
    end
  end

  on_linux do
    url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v#{version}/pandev-cli-plugin_#{version}_Linux_amd64.tar.gz"
    sha256 "4cea2be4da28c3bd766a20f2b0c9f52b371c88624c4d9864f577755461d8bd60"
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
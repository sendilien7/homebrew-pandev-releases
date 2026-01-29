# Formula: pandev-cli-plugin.rb
=begin
After release, update the version and hashes. To get the new hashes run:

curl -sL https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.0.12/pandev-cli-plugin_1.0.12_macOS_amd64.tar.gz | shasum -a 256
curl -sL https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.0.12/pandev-cli-plugin_1.0.12_macOS_arm64.tar.gz | shasum -a 256
curl -sL https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.0.12/pandev-cli-plugin_1.0.12_Linux_amd64.tar.gz | shasum -a 256
=end

class PandevCliPlugin < Formula
  desc "Pandev CLI Plugin"
  homepage "https://github.com/sendilien7/homebrew-pandev-releases"
  version "1.0.12"

  depends_on "jq"
  depends_on "git"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v#{version}/pandev-cli-plugin_#{version}_macOS_amd64.tar.gz"
      sha256 "8a26ff25c7f584ee5083d371a204bbf5461470449ff7a1e1966b0928afce1abe"
    else
      url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v#{version}/pandev-cli-plugin_#{version}_macOS_arm64.tar.gz"
      sha256 "f88c723c11c290d90a9adcff4a7aa07b3d33e42761b971bc4014f8daf178c4bb"
    end
  end

  on_linux do
    url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v#{version}/pandev-cli-plugin_#{version}_Linux_amd64.tar.gz"
    sha256 "18b7a21f1168b2e2a99b6e886d5e01a7f9ffbe96737ba7e02264631c5fc1ba92"
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
# Formula: pandev-cli-plugin.rb
=begin
After release, update the version and hashes. To get the new hashes run:

curl -sL https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.1.3/pandev-cli-plugin_1.1.3_macOS_amd64.tar.gz | shasum -a 256
curl -sL https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.1.3/pandev-cli-plugin_1.1.3_macOS_arm64.tar.gz | shasum -a 256
curl -sL https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.1.3/pandev-cli-plugin_1.1.3_Linux_amd64.tar.gz | shasum -a 256
=end

class PandevCliPlugin < Formula
  desc "Pandev CLI Plugin"
  homepage "https://github.com/sendilien7/homebrew-pandev-releases"
  version "1.1.3"

  depends_on "jq"
  depends_on "git"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v#{version}/pandev-cli-plugin_#{version}_macOS_amd64.tar.gz"
      sha256 "eac5725c037ac303fd143b122f7100e1570227714819c21d64a14da13a7d9f89"
    else
      url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v#{version}/pandev-cli-plugin_#{version}_macOS_arm64.tar.gz"
      sha256 "4fcd0542314ff80abb20812bb67c87ceab720b783078741ecc9483c127826f00"
    end
  end

  on_linux do
    url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v#{version}/pandev-cli-plugin_#{version}_Linux_amd64.tar.gz"
    sha256 "966d2ee73cf9325a7ba3028035c3d616aefbf576dfe7d413c513cee8af540cf6"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/pandev"
    bin.install_symlink libexec/"bin/pandev-cli-plugin"
  end

  def post_install
    # Create UPDATE_AVAILABLE marker to signal watcher.sh to update
    touch libexec/"UPDATE_AVAILABLE"
  end

  test do
    assert_match "version", shell_output("#{bin}/pandev status")
  end
end
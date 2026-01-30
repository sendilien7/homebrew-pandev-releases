# Formula: pandev-cli-plugin.rb
=begin
After release, update the version and hashes. To get the new hashes run:

curl -sL https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.1.0/pandev-cli-plugin_1.1.0_macOS_amd64.tar.gz | shasum -a 256
curl -sL https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.1.0/pandev-cli-plugin_1.1.0_macOS_arm64.tar.gz | shasum -a 256
curl -sL https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.1.0/pandev-cli-plugin_1.1.0_Linux_amd64.tar.gz | shasum -a 256
=end

class PandevCliPlugin < Formula
  desc "Pandev CLI Plugin"
  homepage "https://github.com/sendilien7/homebrew-pandev-releases"
  version "1.1.0"

  depends_on "jq"
  depends_on "git"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v#{version}/pandev-cli-plugin_#{version}_macOS_amd64.tar.gz"
      sha256 "3ac4a260bd351a441541fa88d02de37d2d949a4d91619bb66dd2d4176aff0bb8"
    else
      url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v#{version}/pandev-cli-plugin_#{version}_macOS_arm64.tar.gz"
      sha256 "267406608b9e4237e2eb83789ba3ddc5e0bbbdf0ff8b3d39d5c97effbe843752"
    end
  end

  on_linux do
    url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v#{version}/pandev-cli-plugin_#{version}_Linux_amd64.tar.gz"
    sha256 "76580c203ca46b4fe73f71aaa2f400e2c5c94dee671052d78f8d9609c582bdb6"
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
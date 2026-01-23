# Formula/pandev-cli-plugin.rb
class PandevCliPlugin < Formula
  desc "Your CLI Plugin Description"
  homepage "https://github.com/sendilien7/pandev-releases"
  version "1.0.0" # This must match the version in your build workflow

  if Hardware::CPU.intel?
    url "https://github.com/sendilien7/pandev-releases/releases/download/v1.0.0/pandev-cli-plugin_1.0.0_macOS_amd64.tar.gz"
    sha256 "PASTE_THE_AMD64_SHA256_HASH_HERE" # Replace this after your first release
  else
    url "https://github.com/sendilien7/pandev-releases/releases/download/v1.0.0/pandev-cli-plugin_1.0.0_macOS_arm64.tar.gz"
    sha256 "PASTE_THE_ARM64_SHA256_HASH_HERE" # Replace this after your first release
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/pandev"
    bin.install_symlink libexec/"bin/pandev-cli-plugin"
  end

  def post_install
    system bin/"pandev-cli-plugin", "--install"
  end

  def uninstall
    system bin/"pandev-cli-plugin", "--uninstall"
  end

  test do
    assert_match "version", shell_output("#{bin}/pandev status")
  end
end

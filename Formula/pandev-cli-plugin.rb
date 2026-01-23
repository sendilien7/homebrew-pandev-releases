class PandevCliPlugin < Formula
  desc "Pandev CLI Plugin"
  homepage "https://github.com/sendilien7/homebrew-pandev-releases"
  version "1.0.0"

  if Hardware::CPU.intel?
    url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.0.0/pandev-cli-plugin_1.0.0_macOS_amd64.tar.gz"
    sha256 "REPLACE_WITH_AMD64_HASH"
  else
    url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.0.0/pandev-cli-plugin_1.0.0_macOS_arm64.tar.gz"
    sha256 "REPLACE_WITH_ARM64_HASH"
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
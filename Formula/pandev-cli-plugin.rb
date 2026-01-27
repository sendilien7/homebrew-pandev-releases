=begin

after release just update the versions with the new hashes. To get the new hashes you need to run (don't forget to change
the version):
curl -sL https://github.com/pandev-metriks/homebrew-pandev-cli/releases/download/v1.1.4/pandev-cli-plugin_1.1.4_macOS_amd64.tar.gz | shasum -a 256
curl -sL https://github.com/pandev-metriks/homebrew-pandev-cli/releases/download/v1.1.4/pandev-cli-plugin_1.1.4_macOS_arm64.tar.gz | shasum -a 256
curl -sL https://github.com/pandev-metriks/homebrew-pandev-cli/releases/download/v1.1.4/pandev-cli-plugin_1.1.4_Linux_amd64.tar.gz | shasum -a 256

!!! YOU HAVE TO CHANGE THE VERSIONS IN 4 LINES !!!
=end

class PandevCliPlugin < Formula
  desc "Pandev CLI Plugin"
  homepage "https://github.com/pandev-metriks/homebrew-pandev-cli"
  version "1.1.4"

  if OS.mac?
  if Hardware::CPU.intel?
    url "https://github.com/pandev-metriks/homebrew-pandev-cli/releases/download/v1.1.4/pandev-cli-plugin_1.1.4_macOS_amd64.tar.gz"
    sha256 "c88f0dd49ec82cc10861ae8c82b0c9ec13c3716b862a1f247d5ca69ec1c781d4"
  else
    url "https://github.com/pandev-metriks/homebrew-pandev-cli/releases/download/v1.1.4/pandev-cli-plugin_1.1.4_macOS_arm64.tar.gz"
    sha256 "e144c1d57f10bfcabb98085330cefcbbed5e4118d6d72e4d2c28fbfb3efbd9e2"
    end
  elsif OS.linux?
    url "https://github.com/pandev-metriks/homebrew-pandev-cli/releases/download/v1.1.4/pandev-cli-plugin_1.1.4_Linux_amd64.tar.gz"
    sha256 "LINUX_HASH_HERE"
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

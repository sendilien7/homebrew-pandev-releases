=begin

after release just update the versions with the new hashes. To get the new hashes you need to run (don't forget to change
the version):
curl -sL https://github.com/pandev-metriks/homebrew-pandev-cli/releases/download/v1.1.3/pandev-cli-plugin_1.1.3_macOS_amd64.tar.gz | shasum -a 256
curl -sL https://github.com/pandev-metriks/homebrew-pandev-cli/releases/download/v1.1.3/pandev-cli-plugin_1.1.3_macOS_arm64.tar.gz | shasum -a 256
curl -sL https://github.com/pandev-metriks/homebrew-pandev-cli/releases/download/v1.1.3/pandev-cli-plugin_1.1.3_Linux_amd64.tar.gz | shasum -a 256

!!! YOU HAVE TO CHANGE THE VERSIONS IN 4 LINES !!!
=end

class PandevCliPlugin < Formula
  desc "Pandev CLI Plugin"
  homepage "https://github.com/pandev-metriks/homebrew-pandev-cli"
  version "1.1.3"

  if OS.mac?
  if Hardware::CPU.intel?
    url "https://github.com/pandev-metriks/homebrew-pandev-cli/releases/download/v1.1.3/pandev-cli-plugin_1.1.3_macOS_amd64.tar.gz"
    sha256 "dfb8984716be7bac47d9de160054c2be362f0a615081b2f9a13fb6aff5d93403"
  else
    url "https://github.com/pandev-metriks/homebrew-pandev-cli/releases/download/v1.1.3/pandev-cli-plugin_1.1.3_macOS_arm64.tar.gz"
    sha256 "7648f005a746f6890dae071481e5edb31dc0c38f4da0c8f76ce9c06093bbb5e1"
    end
  elsif OS.linux?
    url "https://github.com/pandev-metriks/homebrew-pandev-cli/releases/download/v1.1.3/pandev-cli-plugin_1.1.3_Linux_amd64.tar.gz"
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

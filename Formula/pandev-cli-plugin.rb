=begin

after release just update the versions with the new hashes. To get the new hashes you need to run (don't forget to change
the version):
curl -sL https://github.com/pandev-metriks/homebrew-pandev-cli/releases/download/v1.1.5/pandev-cli-plugin_1.1.5_macOS_amd64.tar.gz | shasum -a 256
curl -sL https://github.com/pandev-metriks/homebrew-pandev-cli/releases/download/v1.1.5/pandev-cli-plugin_1.1.5_macOS_arm64.tar.gz | shasum -a 256
curl -sL https://github.com/pandev-metriks/homebrew-pandev-cli/releases/download/v1.1.5/pandev-cli-plugin_1.1.5_Linux_amd64.tar.gz | shasum -a 256

!!! YOU HAVE TO CHANGE THE VERSIONS IN 4 LINES !!!
=end

class PandevCliPlugin < Formula
  desc "Pandev CLI Plugin"
  homepage "https://github.com/pandev-metriks/homebrew-pandev-cli"
  version "1.1.5"

  if OS.mac?
  if Hardware::CPU.intel?
    url "https://github.com/pandev-metriks/homebrew-pandev-cli/releases/download/v1.1.5/pandev-cli-plugin_1.1.5_macOS_amd64.tar.gz"
    sha256 "6bce709e14749f7ed04fba99eb469f408fa56b3b4e97119f3fbb57dedd5234a6"
  else
    url "https://github.com/pandev-metriks/homebrew-pandev-cli/releases/download/v1.1.5/pandev-cli-plugin_1.1.5_macOS_arm64.tar.gz"
    sha256 "50161ed35ab8b13ce8465280195ca79549d770777f8719ae0776c55b9136a89c"
    end
  elsif OS.linux?
    url "https://github.com/pandev-metriks/homebrew-pandev-cli/releases/download/v1.1.5/pandev-cli-plugin_1.1.5_Linux_amd64.tar.gz"
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

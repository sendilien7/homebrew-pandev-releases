=begin

after release just update the versions with the new hashes. To get the new hashes you need to run (don't forget to change
the version):
curl -sL https://github.com/pandev-metriks/homebrew-pandev-cli/releases/download/v1.1.2/pandev-cli-plugin_1.1.2_macOS_amd64.tar.gz | shasum -a 256
curl -sL https://github.com/pandev-metriks/homebrew-pandev-cli/releases/download/v1.1.2/pandev-cli-plugin_1.1.2_macOS_arm64.tar.gz | shasum -a 256
curl -sL https://github.com/pandev-metriks/homebrew-pandev-cli/releases/download/v1.1.2/pandev-cli-plugin_1.1.2_Linux_amd64.tar.gz | shasum -a 256

!!! YOU HAVE TO CHANGE THE VERSIONS IN 4 LINES !!!
=end

class PandevCliPlugin < Formula
  desc "Pandev CLI Plugin"
  homepage "https://github.com/pandev-metriks/homebrew-pandev-cli"
  version "1.1.2"

  if OS.mac?
  if Hardware::CPU.intel?
    url "https://github.com/pandev-metriks/homebrew-pandev-cli/releases/download/v1.1.2/pandev-cli-plugin_1.1.2_macOS_amd64.tar.gz"
    sha256 "19b4a7fda93451bfb9b2f2bfe2fa7d7fb9b3a2813ca3c564fe71c09e1c7efccc"
  else
    url "https://github.com/pandev-metriks/homebrew-pandev-cli/releases/download/v1.1.2/pandev-cli-plugin_1.1.2_macOS_arm64.tar.gz"
    sha256 "e59ae036bfff3e8a99be3100f07ec1077b0a1571c2c537a5b76430dc82b56242"
    end
  elsif OS.linux?
    url "https://github.com/pandev-metriks/homebrew-pandev-cli/releases/download/v1.1.2/pandev-cli-plugin_1.1.2_Linux_amd64.tar.gz"
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

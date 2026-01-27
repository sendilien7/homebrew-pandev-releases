=begin

after release just update the versions with the new hashes. To get the new hashes you need to run (don't forget to change
the version):
curl -sL https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.0.3/pandev-cli-plugin_1.0.3_macOS_amd64.tar.gz | shasum -a 256
curl -sL https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.0.3/pandev-cli-plugin_1.0.3_macOS_arm64.tar.gz | shasum -a 256
curl -sL https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.0.3/pandev_1.0.3_amd64.deb | shasum -a 256

!!! YOU HAVE TO CHANGE THE VERSIONS IN 4 LINES !!!
=end

class PandevCliPlugin < Formula
  desc "Pandev CLI Plugin"
  homepage "https://github.com/pandev-metriks/homebrew-pandev-cli"
  version "1.0.3"

  if OS.mac?
  if Hardware::CPU.intel?
    url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.0.3/pandev-cli-plugin_1.0.3_macOS_amd64.tar.gz"
    sha256 "ef1ec187a61dc75a6d340a8aa908c3f5505a888b91afe2325ce857978d5ef769"
  else
    url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.0.3/pandev-cli-plugin_1.0.3_macOS_arm64.tar.gz"
    sha256 "157c46f4b282ce9bb057d285f3f14d677b566a67e100303cb3d71334edac1d99"
    end
  elsif OS.linux?
    url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.0.3/pandev_1.0.3_amd64.deb"
    sha256 "e98f228c1bf09fec907a330e51b633d7c107473f90be34976c10b47148f4ebcf"
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

=begin

after release just update the versions with the new hashes. To get the new hashes you need to run (don't forget to change the version):
curl -sL https://github.com/pandev-metriks/homebrew-pandev-cli/releases/download/v1.0.9/pandev-cli-plugin_1.0.9_macOS_amd64.tar.gz | shasum -a 256
curl -sL https://github.com/pandev-metriks/homebrew-pandev-cli/releases/download/v1.0.9/pandev-cli-plugin_1.0.9_macOS_arm64.tar.gz | shasum -a 256

!!! YOU HAVE TO CHANGE THE VERSIONS IN 3 LINES !!!
=end

class PandevCliPlugin < Formula
  desc "Pandev CLI Plugin"
  homepage "https://github.com/pandev-metriks/homebrew-pandev-cli"
  version "1.0.9"

  if Hardware::CPU.intel?
    url "https://github.com/pandev-metriks/homebrew-pandev-cli/releases/download/v1.0.9/pandev-cli-plugin_1.0.9_macOS_amd64.tar.gz"
    sha256 "6f2fd93fc36ac11facd398658622927d2f3bbf58ff2be7563d4c8469fac2d59e"
  else
    url "https://github.com/pandev-metriks/homebrew-pandev-cli/releases/download/v1.0.9/pandev-cli-plugin_1.0.9_macOS_arm64.tar.gz"
    sha256 "37ca4b73c8c03858be768a096411a0dbc33094f37ee2531ef86ff44bfc8f7825"
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

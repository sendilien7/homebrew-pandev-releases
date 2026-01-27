# After release, update the version and hashes. To get the new hashes run:
#
# curl -sL https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.0.4/pandev-cli-plugin_1.0.4_macOS_amd64.tar.gz | shasum -a 256
# curl -sL https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.0.4/pandev-cli-plugin_1.0.4_macOS_arm64.tar.gz | shasum -a 256
# curl -sL https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.0.4/pandev-cli-plugin_1.0.4_Linux_amd64.tar.gz | shasum -a 256

class PandevCliPlugin < Formula
  desc "Pandev CLI Plugin"
  homepage "https://github.com/sendilien7/homebrew-pandev-releases"
  version "1.0.4"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v#{version}/pandev-cli-plugin_#{version}_macOS_amd64.tar.gz"
      sha256 "c7666143beda855b8da1fa0a6ffd5659378538b0fb4b669923f37b6bca790289"
    else
      url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v#{version}/pandev-cli-plugin_#{version}_macOS_arm64.tar.gz"
      sha256 "85e0d435b0348ddf1cfb8519c6dba13050145d8b78a0587567386739681eb24a"
    end
  end

  on_linux do
    url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v#{version}/pandev-cli-plugin_#{version}_Linux_amd64.tar.gz"
    sha256 "36d3c4877f14ea3dbcdc8ae40b8a41138f47053b3a7edc04db163f9bb3099a32"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/pandev"
    bin.install_symlink libexec/"bin/pandev-cli-plugin"
  end

  def caveats
    <<~EOS
      To complete installation, run:
        sudo pandev-cli-plugin --install

      To uninstall, run before `brew uninstall`:
        sudo pandev-cli-plugin --uninstall
    EOS
  end

  test do
    assert_match "version", shell_output("#{bin}/pandev status")
  end
end

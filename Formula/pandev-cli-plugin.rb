# Formula: pandev-cli-plugin.rb
=begin
After release, update the version and hashes. To get the new hashes run:

curl -sL https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.0.25/pandev-cli-plugin_1.0.25_macOS_amd64.tar.gz | shasum -a 256
curl -sL https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.0.25/pandev-cli-plugin_1.0.25_macOS_arm64.tar.gz | shasum -a 256
curl -sL https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.0.25/pandev-cli-plugin_1.0.25_Linux_amd64.tar.gz | shasum -a 256
=end

class PandevCliPlugin < Formula
  desc "Pandev CLI Plugin"
  homepage "https://github.com/sendilien7/homebrew-pandev-releases"
  version "1.0.25"

  depends_on "jq"
  depends_on "git"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v#{version}/pandev-cli-plugin_#{version}_macOS_amd64.tar.gz"
      sha256 "faa343d510058f807e6f7e1cc74d232baf2500bb3bd6c1e048497ed2958ba164"
    else
      url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v#{version}/pandev-cli-plugin_#{version}_macOS_arm64.tar.gz"
      sha256 "7a88faba005d1be6312564630162dd95a8a08c073d8e0ee03bca28a1366ed49b"
    end
  end

  on_linux do
    url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v#{version}/pandev-cli-plugin_#{version}_Linux_amd64.tar.gz"
    sha256 "98b41cadff462e1e9d6ed88a356e6c509d045bfd395a18fd1a8b9ebdfc3dd451"
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
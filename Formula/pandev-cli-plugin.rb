=begin
After release, update the version and hashes. To get the new hashes run:

curl -sL https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.0.6/pandev-cli-plugin_1.0.6_macOS_amd64.tar.gz | shasum -a 256
curl -sL https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.0.6/pandev-cli-plugin_1.0.6_macOS_arm64.tar.gz | shasum -a 256
curl -sL https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.0.6/pandev-cli-plugin_1.0.6_Linux_amd64.tar.gz | shasum -a 256
=end

class PandevCliPlugin < Formula
  desc "Pandev CLI Plugin"
  homepage "https://github.com/sendilien7/homebrew-pandev-releases"
  version "1.0.6"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v#{version}/pandev-cli-plugin_#{version}_macOS_amd64.tar.gz"
      sha256 "de02dfcd7482087df15a6454c08ccfa71e07970698a44e0372a16fd6340928f3"
    else
      url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v#{version}/pandev-cli-plugin_#{version}_macOS_arm64.tar.gz"
      sha256 "277a5de0ff1dc6bbc7e574af8f8023dd03f59ce9e5338ec1daaaf4e23775c527"
    end
  end

  on_linux do
    url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v#{version}/pandev-cli-plugin_#{version}_Linux_amd64.tar.gz"
    sha256 "17d9c381720bfcce4390b2d09a76737ae30e04434dfa5a46656374fbb478c59c"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/pandev"
    bin.install_symlink libexec/"bin/pandev-cli-plugin"

    # On Linux, create symlinks in /usr/local/bin so sudo can find the commands
    if OS.linux?
      begin
        FileUtils.mkdir_p("/usr/local/bin")
        FileUtils.ln_sf("#{bin}/pandev", "/usr/local/bin/pandev")
        FileUtils.ln_sf("#{bin}/pandev-cli-plugin", "/usr/local/bin/pandev-cli-plugin")
      rescue Errno::EACCES
        opoo "Could not create symlinks in /usr/local/bin. You may need to run:"
        opoo "  sudo ln -sf #{bin}/pandev-cli-plugin /usr/local/bin/pandev-cli-plugin"
      end
    end
  end

  def caveats
    if OS.linux?
      <<~EOS
        To complete installation, run:
          sudo $(which pandev-cli-plugin) --install

        After installation, you can use 'sudo pandev' directly.

        To uninstall, run before `brew uninstall`:
          sudo pandev-cli-plugin --uninstall
      EOS
    else
      <<~EOS
        To complete installation, run:
          sudo pandev-cli-plugin --install

        To uninstall, run before `brew uninstall`:
          sudo pandev-cli-plugin --uninstall
      EOS
    end
  end

  test do
    assert_match "version", shell_output("#{bin}/pandev status")
  end
end

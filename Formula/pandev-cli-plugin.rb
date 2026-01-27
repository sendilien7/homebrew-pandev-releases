=begin
After release, update the version and hashes. To get the new hashes run:

curl -sL https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.0.5/pandev-cli-plugin_1.0.5_macOS_amd64.tar.gz | shasum -a 256
curl -sL https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.0.5/pandev-cli-plugin_1.0.5_macOS_arm64.tar.gz | shasum -a 256
curl -sL https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v1.0.5/pandev-cli-plugin_1.0.5_Linux_amd64.tar.gz | shasum -a 256
=end

class PandevCliPlugin < Formula
  desc "Pandev CLI Plugin"
  homepage "https://github.com/sendilien7/homebrew-pandev-releases"
  version "1.0.5"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v#{version}/pandev-cli-plugin_#{version}_macOS_amd64.tar.gz"
      sha256 "042c4f9d1396c57e51792352b33997016f8208423c96f056eb500dd0b029c5e3"
    else
      url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v#{version}/pandev-cli-plugin_#{version}_macOS_arm64.tar.gz"
      sha256 "104a888b415ec44d95ac28338001295d18c500dd99eb6f672d5661c8f3b9c3c9"
    end
  end

  on_linux do
    url "https://github.com/sendilien7/homebrew-pandev-releases/releases/download/v#{version}/pandev-cli-plugin_#{version}_Linux_amd64.tar.gz"
    sha256 "199adcd9dcee1fc7fc6c19874a243c932f506a0e0f9b88c1ae04c8da72f17b3a"
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

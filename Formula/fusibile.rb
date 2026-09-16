class Fusibile < Formula
  desc "Mount remote file systems locally via FUSE or Dokany"
  homepage "https://github.com/remotefs-rs/remotefs-rs-fuse"
  license "MIT"
  version "1.0.0"

  on_macos do
    # The Apple Silicon build vendors Samba, which links gnutls/libunistring
    # dynamically. The Intel build has no SMB support at all, see caveats below.
    on_arm do
      depends_on "gnutls"
      depends_on "libunistring"
      url "https://github.com/remotefs-rs/remotefs-rs-fuse/releases/latest/download/fusibile-v1.0.0-aarch64-apple-darwin.tar.gz"
      sha256 "5b4b1b1b0383770705509486022d5a011918ed35cc3a511ab29e984c11b2b0a5"
    end
    on_intel do
      url "https://github.com/remotefs-rs/remotefs-rs-fuse/releases/latest/download/fusibile-v1.0.0-x86_64-apple-darwin.tar.gz"
      sha256 "ea7272d49668eb64d123129967f41cf00e122285e983eeedf7d1e851944ed45c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/remotefs-rs/remotefs-rs-fuse/releases/latest/download/fusibile-v1.0.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "7eaa5b71fd5bd1518b8ea27215f35b321facf5368a9e420129ce9e5074ac1485"
    end
    on_intel do
      url "https://github.com/remotefs-rs/remotefs-rs-fuse/releases/latest/download/fusibile-v1.0.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a8b7d8ebaad293137552d9989c43fdf8dddbce5b0262f05ac7f766d187ba8738"
    end
  end

  def install
    bin.install "fusibile"
  end

  def caveats
    on_macos do
      <<~CAVEATS
        fusibile needs macFUSE, which Homebrew cannot install as a formula
        dependency. Install it first with "brew install --cask macfuse".
        macOS will ask you to allow the system extension in System Settings ->
        Privacy & Security the first time you mount anything.
      CAVEATS
      on_intel do
        <<~CAVEATS
          This build has no SMB support: vendoring Samba fails to link on Intel
          macOS. Build from source with "cargo install fusibile --locked" if you
          need it.
        CAVEATS
      end
    end
    on_linux do
      <<~CAVEATS
        fusibile needs the setuid fusermount3 binary from your distribution's
        fuse3 package, which Homebrew cannot provide. Install it with your
        system package manager, e.g. "sudo apt-get install fuse3".
      CAVEATS
    end
  end

  test do
    assert_match "fusibile", shell_output("#{bin}/fusibile --help")
  end
end

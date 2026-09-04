class Fusibile < Formula
  desc "Mount remote file systems locally via FUSE or Dokany"
  homepage "https://github.com/remotefs-rs/remotefs-rs-fuse"
  license "MIT"
  version "0.2.0"

  on_macos do
    # The Apple Silicon build vendors Samba, which links gnutls/libunistring
    # dynamically. The Intel build has no SMB support at all, see caveats below.
    on_arm do
      depends_on "gnutls"
      depends_on "libunistring"
      url "https://github.com/remotefs-rs/remotefs-rs-fuse/releases/latest/download/fusibile-v0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "df6d72a974b08c17033b597d7221de3d0173a6045ab153a3afaf28bbd3368af1"
    end
    on_intel do
      url "https://github.com/remotefs-rs/remotefs-rs-fuse/releases/latest/download/fusibile-v0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "0800701f12a129065d271b7a5b93cafb654c7ec1b3af2af818938c0c667175ef"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/remotefs-rs/remotefs-rs-fuse/releases/latest/download/fusibile-v0.2.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "5d27e61227ff253ba314fbf9612f5b6bae3e7e891216953021dc76fa1b8e4d0d"
    end
    on_intel do
      url "https://github.com/remotefs-rs/remotefs-rs-fuse/releases/latest/download/fusibile-v0.2.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "de0603dbb2f2fcbd56d99c781218b5e65acfe1824bc54d4ee335d02c431b98e5"
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

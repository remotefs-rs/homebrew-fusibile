class Fusibile < Formula
  desc "Mount remote file systems locally via FUSE or Dokany"
  homepage "https://github.com/remotefs-rs/remotefs-rs-fuse"
  license "MIT"
  version "0.0.0"

  on_macos do
    depends_on cask: "macfuse"
    depends_on "gnutls"
    depends_on "libunistring"

    on_arm do
      url "https://github.com/remotefs-rs/remotefs-rs-fuse/releases/latest/download/fusibile-v0.0.0-aarch64-apple-darwin.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000"
    end
    on_intel do
      url "https://github.com/remotefs-rs/remotefs-rs-fuse/releases/latest/download/fusibile-v0.0.0-x86_64-apple-darwin.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/remotefs-rs/remotefs-rs-fuse/releases/latest/download/fusibile-v0.0.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000"
    end
    on_intel do
      url "https://github.com/remotefs-rs/remotefs-rs-fuse/releases/latest/download/fusibile-v0.0.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000"
    end
  end

  def install
    bin.install "fusibile"
  end

  def caveats
    on_macos do
      <<~CAVEATS
        fusibile needs macFUSE. macOS will ask you to allow the system extension
        in System Settings -> Privacy & Security the first time you mount anything.
      CAVEATS
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

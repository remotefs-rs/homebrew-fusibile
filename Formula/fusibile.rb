class Fusibile < Formula
  desc "Mount remote file systems locally via FUSE or Dokany"
  homepage "https://github.com/remotefs-rs/remotefs-rs-fuse"
  license "MIT"
  version "0.3.0"

  on_macos do
    # The Apple Silicon build vendors Samba, which links gnutls/libunistring
    # dynamically. The Intel build has no SMB support at all, see caveats below.
    on_arm do
      depends_on "gnutls"
      depends_on "libunistring"
      url "https://github.com/remotefs-rs/remotefs-rs-fuse/releases/latest/download/fusibile-v0.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "f58fa880401d826f860e505512f2e22827dbf0e57a0e79c91d4b0eb2c3f69ce2"
    end
    on_intel do
      url "https://github.com/remotefs-rs/remotefs-rs-fuse/releases/latest/download/fusibile-v0.3.0-x86_64-apple-darwin.tar.gz"
      sha256 "39cb67f7e959dcd2762e828d9584332ba4705b12a2d6ffa02fbfc13eaac27b75"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/remotefs-rs/remotefs-rs-fuse/releases/latest/download/fusibile-v0.3.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "94b9b7c1ecb64d04a69691f5682d47b2e8be73e7e17704cc71cc621192ec9610"
    end
    on_intel do
      url "https://github.com/remotefs-rs/remotefs-rs-fuse/releases/latest/download/fusibile-v0.3.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "638cffa18b0917c27fd2d6027c5723a7a4226a54d756b2919943ffdf498078f7"
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

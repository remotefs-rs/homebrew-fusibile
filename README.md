# homebrew-fusibile

Homebrew tap for [fusibile](https://github.com/remotefs-rs/remotefs-rs-fuse), a CLI that mounts
remote file systems locally via FUSE or Dokany.

## Install

```sh
brew install remotefs-rs/fusibile/fusibile
```

On macOS this also installs the macFUSE cask; macOS will ask you to allow the system extension
in System Settings the first time you mount anything.

On Linux you additionally need the setuid `fusermount3` binary from your distribution's `fuse3`
package, which Homebrew cannot provide.

## Maintenance

`Formula/fusibile.rb` is **generated** by the `publish-homebrew` job of the
[release workflow](https://github.com/remotefs-rs/remotefs-rs-fuse/blob/main/.github/workflows/release.yml).
Do not edit it by hand — the next release will overwrite your changes. Change the generator
instead.

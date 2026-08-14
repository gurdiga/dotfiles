---
name: gem-security-update
description: Fix Dependabot security alerts for Ruby gems. Use when the user shares a GitHub Dependabot URL, asks to fix gem vulnerabilities, or mentions a gem CVE needing a version bump.
disable-model-invocation: true
---

# Gem Security Update

## Workflow

### 1. Identify the alerts

```bash
gh api repos/OWNER/REPO/dependabot/alerts \
  --jq '.[] | select(.state == "open") | {package: .security_vulnerability.package.name, fixed_in: .security_vulnerability.first_patched_version.identifier, severity: .security_advisory.severity}'
```

### 2. Check current versions and Ruby

```bash
grep 'PACKAGE_NAME' Gemfile.lock
cat .ruby-version
```

### 3. Check if the fix requires a newer Ruby

```bash
gem specification PACKAGE_NAME --version 'FIXED_VERSION' --remote 2>/dev/null | grep -A5 'required_ruby'
```

If a Ruby upgrade is needed:

#### Find latest patch version

```bash
curl -s https://cache.ruby-lang.org/pub/ruby/X.Y/ | grep -oE 'ruby-X\.Y\.[0-9]+\.tar\.gz' | sort -V | tail -1
```

#### Install via RVM (macOS requires explicit OpenSSL path)

Derive the prefix rather than hardcoding it — it differs between Apple Silicon
(`/opt/homebrew`) and Intel (`/usr/local`):

```bash
rvm install X.Y.Z --with-openssl-dir="$(brew --prefix openssl@3)"
```

#### Update `.ruby-version`

Edit `.ruby-version` to the new version.

### 4. Install gems and update the vulnerable gem

```bash
rvm X.Y.Z do bundle install
rvm X.Y.Z do bundle update PACKAGE_NAME
```

If other gems also fail to install (e.g. `ffi` compile errors on macOS), update them too:

```bash
rvm X.Y.Z do bundle update PACKAGE_NAME ffi
```

### 5. Check for Ruby version compatibility issues in the Gemfile

Ruby 3.4+ dropped some previously default gems (e.g. `csv`, `base64`, `logger`). If the build
fails with `cannot load such file -- csv` (or similar), add the gem explicitly:

```ruby
gem "csv" # required by jekyll on Ruby 3.4+
```

Then re-run `bundle install`.

### 6. Update CI workflows

Search for GitHub Actions workflows that pin a Ruby version:

```bash
grep -r 'ruby-version' .github/workflows/
```

Update any `ruby-version: 'X.Y'` entries to match the new version (major.minor is fine, e.g. `'3.4'`).

### 7. Commit and push

These commits bypass the pre-commit hook (`--no-verify`) because the hook itself may depend on
the old Ruby environment:

```bash
git add .ruby-version Gemfile Gemfile.lock .github/workflows/
git commit --no-verify -m "Upgrade Ruby to X.Y.Z and PACKAGE to VERSION

PACKAGE VERSION fixes a SEVERITY severity CVE and requires
Ruby >= X.Y, so upgrade Ruby from OLD to X.Y.Z."
git push
```

## Notes

- This workflow assumes RVM and Homebrew. On a machine using rbenv/chruby, or Linux without Homebrew, the version-manager and OpenSSL steps need translating — the rest of the workflow still holds.
- RVM on macOS often can't find binary rubies for the latest macOS releases and compiles from source — this is normal and takes a few minutes.
- The `openssl@1.1` Homebrew formula was removed; always point `--with-openssl-dir` at `openssl@3`.
- Dependabot alerts auto-dismiss once GitHub rescans after the push (usually within minutes).
- If multiple repos need the same fix, check each one's `.ruby-version` and `Gemfile.lock` — they may be on different Ruby versions.

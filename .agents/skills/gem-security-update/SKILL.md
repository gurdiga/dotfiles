---
name: gem-security-update
description: Remediate Dependabot security alerts for Ruby gems with conservative dependency and toolchain changes. Use only when invoked as $gem-security-update.
---

# Gem Security Update

Remediate the requested Ruby gem vulnerability with the smallest compatible dependency and toolchain change. Keep inspection and verification automatic; require explicit user authorization before committing, bypassing hooks, or pushing.

## Inspect the alert and repository

1. Confirm the repository and requested alert scope. If a Dependabot URL identifies an alert number, inspect that alert directly with `gh api repos/OWNER/REPO/dependabot/alerts/ALERT_NUMBER`. Otherwise list open alerts with `--paginate`.
2. Read applicable `AGENTS.md` files and discover every dependency or runtime pin, including `Gemfile`, gemspecs, `Gemfile.lock` and its `BUNDLED WITH` section, `.ruby-version`, `.tool-versions`, `mise.toml`, CI workflows, containers, and deployment configuration when present.
3. Record the vulnerable package, current version, first patched version, severity, and advisory identifier. Prefer GitHub advisory data and the gem's published metadata over guesses.
4. Check the working tree before editing. Preserve unrelated user changes.

Example read-only query:

```bash
gh api --paginate repos/OWNER/REPO/dependabot/alerts \
  --jq '.[] | select(.state == "open") | {number, package: .security_vulnerability.package.name, fixed_in: .security_vulnerability.first_patched_version.identifier, severity: .security_advisory.severity, ghsa: .security_advisory.ghsa_id}'
```

## Choose the smallest safe update

1. If the advisory has no `first_patched_version`, the patched release is yanked or unavailable, or the dependency graph cannot resolve it, stop and report the constraint. Propose a mitigation or broader upgrade separately; do not invent a patched version.
2. Check whether the patched gem supports the repository's Ruby version:

```bash
gem specification PACKAGE --version PATCHED_VERSION --remote required_ruby_version
```

3. Use the repository's wrapper when present and the Ruby and Bundler versions pinned by the repository. Update only the vulnerable gem when the current Ruby version is supported:

```bash
bundle update --conservative PACKAGE
```

4. If the installed Bundler does not support `--conservative`, use the narrowest supported targeted-update command and explain any additional lockfile movement.
5. If the patched gem requires a newer Ruby, select the smallest supported Ruby upgrade that satisfies the gem and the repository's other constraints. Update every discovered runtime pin together.
6. Before installing a Ruby runtime, Homebrew package, version manager, or other component outside the repository, explain the change and obtain user authorization. Adapt authorized commands to the existing manager (`rvm`, `rbenv`, `asdf`, `mise`, or another tool).
7. After authorization, macOS RVM compilation should derive Homebrew prefixes instead of hardcoding architecture-specific paths:

```bash
rvm install X.Y.Z --with-openssl-dir="$(brew --prefix openssl@3)"
```

8. Add formerly default gems such as `csv`, `base64`, or `logger` only when the upgraded Ruby exposes a demonstrated load failure.

## Verify the remediation

1. Run `bundle check`, the repository's relevant test or build commands, and any existing dependency or security audit command.
2. Inspect `git diff` and `git status`. Confirm the lockfile resolves the vulnerable gem to a patched version and that unrelated dependencies did not move without cause.
3. Re-query the alert only after a user-authorized push and GitHub's rescan. Do not claim the remote alert is closed based only on a local lockfile.
4. Report the advisory, old and new versions, Ruby/toolchain changes, verification performed, and residual risks.

## Guard external writes

- Do not commit or push unless the user explicitly requests it.
- Do not use `--no-verify` unless the user explicitly approves bypassing hooks after seeing why the hooks cannot run.
- Do not broaden the update to unrelated gems merely to make the lockfile newer. Include an additional gem only when it is required to resolve or verify the security update, and explain why.

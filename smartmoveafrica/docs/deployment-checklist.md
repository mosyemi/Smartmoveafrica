# Deployment Checklist

## Release Metadata
- Set app label and package id for production.
- Increment `version` in `pubspec.yaml`.
- Prepare screenshots and store listing text.

## Build & Validation
- Run `flutter analyze`.
- Run `flutter test`.
- Run `flutter build apk --release`.
- Run `flutter build appbundle --release`.

## Security
- Verify secure storage usage for session tokens.
- Confirm no secrets are committed.
- Review Android manifest permissions.

## Play Store Submission
- Upload signed AAB to internal testing first.
- Validate crashes and ANRs in pre-launch report.
- Promote to closed testing, then production.

## Maintenance
- Monitor crash-free users.
- Track app startup time and key flow latency.
- Maintain backlog for future expansion modules.

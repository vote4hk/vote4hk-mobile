# vote4hk_mobile

Vote4HK Mobile App

## Getting Started

- Install flutter and dependencies ...
- Get the google map API key for ios and android. [Guide](https://pub.dev/packages/google_maps_flutter)

For iOS prepare the AppDelegate.m

```bash
cp ./ios/Runner/AppDelegate.swift.sample ./ios/Runner/AppDelegate.swift

# and modify the API key there
```

For Android prepare the `android/app/src/main/AndroidManifest.xml`

```bash
cp ./android/app/src/main/AndroidManifest.xml.sample ./android/app/src/main/AndroidManifest.xml

# and modify the API key there
```

Or you can simply do a full text search to lookup `YOUR KEY HERE` to replace it.

## Localization

Checked Intl package and it requries too much work. To keep thing simple, we are using json as i18n tools right now. All the related translation files can be found at `./assets/i18n/*.json`


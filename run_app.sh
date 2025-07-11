#!/bin/bash

# Cleanup
fvm flutter clean

# Get packages
fvm flutter pub get

# Run the app
fvm flutter run --flavor development --target lib/main_development.dart --dart-define=FLAVOR=development 
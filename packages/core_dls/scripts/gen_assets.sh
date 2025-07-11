#!/bin/bash
set -e

cd ..
echo "$PWD"
dart pub global activate flutter_gen
fluttergen -c pubspec.yaml

cd lib/src/constants/
package_name="base_dls"
old="String? package"
new="String? package = '$package_name'"
generated_file_name="assets.gen.dart"

sed -i'' -e'' "s/$old/$new/g" $generated_file_name
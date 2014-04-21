#!/bin/sh
xcodebuild -project SKJControl.xcodeproj -scheme SKJControl build
xcodebuild -project SKJControl.xcodeproj -scheme SKJControl -destination name="iPhone Retina (3.5-inch)",OS="7.1" test
xcodebuild -project SKJControl.xcodeproj -scheme SKJControl -destination name="iPhone Retina (4-inch)",OS="7.1" test
xcodebuild -project SKJControl.xcodeproj -scheme SKJControl -destination name="iPhone Retina (4-inch 64-bit)",OS="7.1" test
xcodebuild -project SKJControl.xcodeproj -scheme SKJControl -destination name="iPhone Retina (3.5-inch)",OS="7.0" test
xcodebuild -project SKJControl.xcodeproj -scheme SKJControl -destination name="iPhone Retina (4-inch)",OS="7.0" test
xcodebuild -project SKJControl.xcodeproj -scheme SKJControl -destination name="iPhone Retina (4-inch 64-bit)",OS="7.0" test

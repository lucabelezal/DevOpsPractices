#!/bin/sh

set -o pipefail
	xcodebuild test-without-building \
	-workspace CSBootcamp.xcworkspace \
	-scheme CSBootcamp \
	-destination 'platform=iOS Simulator,name=iPhone 12' \
	-derivedDataPath '~/Library/Developer/Xcode/DerivedData' \
	-enableCodeCoverage YES \
	| xcpretty

slather coverage --sonarqube-xml --output-directory build/Coverage/ --scheme CSBootcamp --binary-basename CSBootcamp
slather coverage -s
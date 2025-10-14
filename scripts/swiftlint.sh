#!/bin/zsh
if [[ -z "$CI" ]]; then
    if [[ "$(uname -m)" == arm64 ]]; then
        export PATH="/opt/homebrew/bin:$PATH"
    fi

    # Check if running in a SwiftUI preview
    if [ "$XCODE_RUNNING_FOR_PREVIEWS" != "1" ]; then
        if which swiftlint > /dev/null; then
            swiftlint # Uncomment if you want to auto-fix: swiftlint --fix &&
        else
            echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
        fi
    fi
else 
    # Running Xcode Cloud
    echo "Running in Xcode Cloud. Skipping SwiftLint."
fi

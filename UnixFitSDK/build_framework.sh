# A shell script for creating an XCFramework for iOS.

# Starting from a clean slate
# Removing the build and output folders
rm -rf ./build &&\
rm -rf ./output &&\

# Cleaning the workspace cache
xcodebuild \
    clean \
    -project UnixFitSDK.xcodeproj \
    -scheme UnixFitSDK

# Create an archive for iOS devices
xcodebuild \
    archive \
        SKIP_INSTALL=NO \
        BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
        -project UnixFitSDK.xcodeproj \
        -scheme UnixFitSDK \
        -configuration Release \
        -destination "generic/platform=iOS" \
        -archivePath build/UnixFitSDK-iOS.xcarchive

# Create an archive for iOS simulators
xcodebuild \
    archive \
        SKIP_INSTALL=NO \
        BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
        -project UnixFitSDK.xcodeproj \
        -scheme UnixFitSDK \
        -configuration Release \
        -destination "generic/platform=iOS Simulator" \
        -archivePath build/UnixFitSDK-iOS_Simulator.xcarchive

# Convert the archives to .framework
# and package them both into one xcframework
xcodebuild \
    -create-xcframework \
    -archive build/UnixFitSDK-iOS.xcarchive -framework UnixFitSDK.framework \
    -archive build/UnixFitSDK-iOS_Simulator.xcarchive -framework UnixFitSDK.framework \
    -output output/UnixFitSDK.xcframework &&\
    rm -rf build

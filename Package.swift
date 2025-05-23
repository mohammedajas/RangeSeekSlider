// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RangeSeekSlider",
    platforms: [
         .iOS(.v14)
       ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "RangeSeekSlider",
            targets: ["RangeSeekSlider"]),
    ],
    targets: [
        .target(
          name: "RangeSeekSlider",
          path: "Sources/RangeSeekSlider"
        )
      ]
)

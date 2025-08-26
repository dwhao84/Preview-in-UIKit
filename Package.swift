// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "PreviewInUIKit",
    platforms: [
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6),
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "PreviewInUIKit", targets: ["PreviewInUIKit"])
    ],
    targets: [
        .target(
            name: "PreviewInUIKit",
            path: "Sources/PreviewInUIKit"
        ),
        .testTarget(
            name: "PreviewInUIKitTests",
            dependencies: ["PreviewInUIKit"],
            path: "Tests/PreviewInUIKitTests"
        )
    ]
)

// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let debugOtherSwiftFlags = [
    "-Xfrontend", "-warn-long-expression-type-checking=500",
    "-Xfrontend", "-warn-long-function-bodies=500",
    "-strict-concurrency=complete",
    "-enable-actor-data-race-checks",
]

let debugSwiftSettings: [PackageDescription.SwiftSetting] = [ // Swift5.8
    .unsafeFlags(debugOtherSwiftFlags, .when(configuration: .debug)),
    .enableUpcomingFeature("ConciseMagicFile", .when(configuration: .debug)), // SE-0274
    .enableUpcomingFeature("ForwardTrailingClosures", .when(configuration: .debug)), // SE-0286
    .enableUpcomingFeature("ExistentialAny", .when(configuration: .debug)), // SE-0335
    .enableUpcomingFeature("BaseSlashRegexLiterals", .when(configuration: .debug)), // SE-0354
]

let package = Package(
    name: "Package",
    defaultLocalization: "ja",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(name: "App", targets: ["App"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/uber/needle.git", .upToNextMajor(from: "0.22.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        
        // === Dependency Injection -----
        
        .target(
            name: "DI",
            dependencies: [
                "Domain",
                "Data/Repository",
                .product(name: "NeedleFoundation", package: "needle")
            ]
        ),
        
        // === Application -----
        
        .target(
            name: "App",
            dependencies: [
                "DI",
                "UI/Home",
                "UI/Search",
                "UI/Setting",
                "UI/SideMenu",
                "UI/Sign",
                "UI/Splash",
                "UI/TabHome",
                "UI/Web",
                .product(name: "NeedleFoundation", package: "needle")
            ]
//            plugins: ["SwiftLint"]
        ),
        
        // === UI -----
        
        .target(
            name: "UI/Core",
            dependencies: ["Domain"],
            path: "Sources/UI/Core",
            swiftSettings: debugSwiftSettings,
            plugins: ["SwiftGen"]
        ),
        .target(
            name: "UI/Home",
            dependencies: ["DI", "UI/Core", "Domain"],
            path: "Sources/UI/Home",
            swiftSettings: debugSwiftSettings
        ),
        .target(
            name: "UI/Search",
            dependencies: ["UI/Core"],
            path: "Sources/UI/Search",
            swiftSettings: debugSwiftSettings
        ),
        .target(
            name: "UI/Setting",
            dependencies: ["UI/Core"],
            path: "Sources/UI/Setting",
            swiftSettings: debugSwiftSettings
        ),
        .target(
            name: "UI/SideMenu",
            dependencies: ["DI"],
            path: "Sources/UI/SideMenu",
            swiftSettings: debugSwiftSettings
        ),
        .target(
            name: "UI/Sign",
            dependencies: ["DI", "UI/Core"],
            path: "Sources/UI/Sign",
            swiftSettings: debugSwiftSettings
        ),
        .target(
            name: "UI/Splash",
            path: "Sources/UI/Splash",
            swiftSettings: debugSwiftSettings
        ),
        .target(
            name: "UI/TabHome",
            dependencies: ["DI"],
            path: "Sources/UI/TabHome",
            swiftSettings: debugSwiftSettings
        ),
        .target(
            name: "UI/Web",
            path: "Sources/UI/Web",
            swiftSettings: debugSwiftSettings
        ),
        
        // === Domain -----
        
        .target(
            name: "Domain",
            swiftSettings: debugSwiftSettings
        ),
        
        // === Data -----
        
        .target(
            name: "Data/Core",
            dependencies: ["Domain"],
            path: "Sources/Data/Core",
            swiftSettings: debugSwiftSettings
        ),
        .target(
            name: "Data/Local",
            path: "Sources/Data/Local",
            swiftSettings: debugSwiftSettings
        ),
        .target(
            name: "Data/Rempte",
            dependencies: ["Data/Core"],
            path: "Sources/Data/Remote",
            swiftSettings: debugSwiftSettings
        ),
        .target(
            name: "Data/Repository",
            dependencies: [
                "Domain",
                "Data/Rempte",
                .product(name: "NeedleFoundation", package: "needle")
            ],
            path: "Sources/Data/Repository",
            swiftSettings: debugSwiftSettings
        ),

        
        // === Plugins -----
        
        .binaryTarget(
            name: "SwiftLintBinary",
            path: "./../Artifacts/SwiftLintBinary.artifactbundle"
        ),
        .plugin(
            name: "SwiftLint",
            capability: .buildTool(),
            dependencies: ["SwiftLintBinary"]
        ),

        .binaryTarget(
            name: "SwiftGenBinary",
            path: "./../Artifacts/SwiftGenBinary.artifactbundle"
        ),
        .plugin(
            name: "SwiftGen",
            capability: .buildTool(),
            dependencies: ["SwiftGenBinary"]
        ),
        
        // ==== Tests -----
        
        .testTarget(
            name: "PackageTests",
            dependencies: []
        )
    ]
)

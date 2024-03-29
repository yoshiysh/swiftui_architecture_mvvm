// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

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
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        
        // === Dependency Injection -----
        
        .target(
            name: "DI",
            dependencies: ["Domain", "Data/Repository"]
        ),
        
        // === Application -----
        
        .target(
            name: "App",
            dependencies: [
                "UI/Home",
                "UI/Search",
                "UI/Setting",
                "UI/SideMenu",
                "UI/Sign",
                "UI/Splash",
                "UI/TabHome",
                "UI/Web"
            ],
            plugins: ["SwiftLint"]
        ),
        
        // === UI -----
        
        .target(
            name: "UI/Core",
            dependencies: ["Domain"],
            path: "Sources/UI/Core",
            plugins: ["SwiftGen"]
        ),
        .target(
            name: "UI/Home",
            dependencies: ["DI", "UI/Core", "Domain"],
            path: "Sources/UI/Home"
        ),
        .target(
            name: "UI/Search",
            dependencies: ["UI/Core"],
            path: "Sources/UI/Search"
        ),
        .target(
            name: "UI/Setting",
            dependencies: ["UI/Core"],
            path: "Sources/UI/Setting"
        ),
        .target(
            name: "UI/SideMenu",
            dependencies: ["DI"],
            path: "Sources/UI/SideMenu"
        ),
        .target(
            name: "UI/Sign",
            dependencies: ["DI", "UI/Core"],
            path: "Sources/UI/Sign"
        ),
        .target(
            name: "UI/Splash",
            path: "Sources/UI/Splash"
        ),
        .target(
            name: "UI/TabHome",
            dependencies: ["DI"],
            path: "Sources/UI/TabHome"
        ),
        .target(
            name: "UI/Web",
            path: "Sources/UI/Web"
        ),
        
        // === Domain -----
        
        .target(name: "Domain"),
        
        // === Data -----
        
        .target(
            name: "Data/Core",
            dependencies: ["Domain"],
            path: "Sources/Data/Core"
        ),
        .target(
            name: "Data/Local",
            path: "Sources/Data/Local"
        ),
        .target(
            name: "Data/Rempte",
            dependencies: ["Data/Core"],
            path: "Sources/Data/Remote"
        ),
        .target(
            name: "Data/Repository",
            dependencies: ["Domain", "Data/Rempte"],
            path: "Sources/Data/Repository"
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

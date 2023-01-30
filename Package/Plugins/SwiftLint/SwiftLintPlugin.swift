//
//  SwiftLintPlugin.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/10/05.
//

import PackagePlugin

@main
struct SwiftLintPlugin: BuildToolPlugin {
    func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
        [
            .buildCommand(
                displayName: "Running SwiftLint for \(target.name)",
                executable: try context.tool(named: "swiftlint").path,
                arguments: [
                    "--config", "\(context.package.directory.string)/../.swiftlint.yml",
                    "--no-cache",
                    "--quiet",
                    "--format"
                ],
                environment: [:]
            )
        ]
    }
}

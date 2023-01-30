//
//  SwiftGenPlugin.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/10/06.
//

import PackagePlugin

@main
struct SwiftGenPlugin: BuildToolPlugin {
    func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
        [
            .prebuildCommand(
                displayName: "Running SwiftGen",
                executable: try context.tool(named: "swiftgen").path,
                arguments: [
                    "config",
                    "run",
                    "--config", "\(target.directory.string)/Resources/swiftgen.yml"
                ],
                environment: [
                    "OUTPUT_DIR": context.pluginWorkDirectory.string
                ],
                outputFilesDirectory: context.pluginWorkDirectory
            )
        ]
    }
}

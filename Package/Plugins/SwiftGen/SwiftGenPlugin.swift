//
//  SwiftGenPlugin.swift
//
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
                    "--config", "\(context.package.directory.string)/../swiftgen.yml"
                ],
                environment: [
                    "INPUT_DIR": context.package.directory.string,
                    "OUTPUT_DIR": context.pluginWorkDirectory.string
                ],
                outputFilesDirectory: context.pluginWorkDirectory
            )
        ]
    }
}

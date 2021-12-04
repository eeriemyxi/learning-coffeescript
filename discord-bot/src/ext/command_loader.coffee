fs = require "fs"
path = require "path"
parent_dir = require "find-parent-dir"
chalk = require "chalk"

module.exports = (bot) ->
    parent_dir __dirname, 'commands', (err, dir) ->
        commands_path = path.join dir, "commands"
        fs.readdir commands_path, (e, files) ->
            for file in files
                unless file.startsWith "_"
                    command = require path.join commands_path, file
                    command.command(bot)
                    console.log chalk.green "Loaded file: #{file}"

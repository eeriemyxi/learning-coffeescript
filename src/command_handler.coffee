enquirer     = require "enquirer"
Utility      = require "./ext/utils"
terminal_kit = require "terminal-kit"

term  = new terminal_kit.Terminal
utils = new Utility

class CommandHandler
    constructor: (commands) ->
        @commands = commands

    start: () ->
        if @commands.ready()
            loop
                response = await enquirer.prompt
                    type: "input"
                    name: "command_string"
                    message: "Enter command"

                command_string = response.command_string
                command_string_split = command_string.trim().split " "
                user_command_name = command_string_split[0]
                user_command_args = command_string_split[1..]

                for command in @commands.command_list
                    if command.name is user_command_name
                        func_params = utils.get_params command.func
                        if func_params[-1..][0] is "$"
                            consume_rest = user_command_args[func_params.length - 1..]
                            user_command_args = user_command_args[..func_params.length - 2]
                        await command.func user_command_args..., (
                            if consume_rest? then consume_rest.join " "
                        )
                

module.exports = CommandHandler
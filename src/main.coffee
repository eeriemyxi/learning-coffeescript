Handler  = require "./command_handler"
Commands = require "./commands"


commands = new Commands
handler  = new Handler commands

handler.start()

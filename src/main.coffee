Handler  = (require "./command_handler").Handler
Commands = (require "./commands").Commands


commands = new Commands
handler  = new Handler commands

handler.start()

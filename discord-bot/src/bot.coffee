Eris = require "eris"
yaml = require "yaml"
fs = require "fs"
loader = require "./ext/command_loader"
chalk = require "chalk"


config = yaml.parse fs.readFileSync "./config.yml", "utf-8"

class MyBot extends Eris.CommandClient
    send: (msg, obj) ->
        super.createMessage msg.channel.id, obj
    command: (stuff...) ->
        super.registerCommand stuff...


bot = new MyBot config.TOKEN, {},
    description: "Learning coffeescript."
    owner: "Myxi"
    prefix: "."

bot.on "ready", () ->
    console.log chalk.magenta "Bot is ready."

loader(bot)
bot.connect()
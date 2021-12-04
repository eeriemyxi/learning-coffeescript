exports.command = (bot) ->
    bot.command "say", (msg, args) ->
        bot.send msg,
            content: args.join(" ")
    ,
    description: "Make the bot say something."
    usage: "<message>"
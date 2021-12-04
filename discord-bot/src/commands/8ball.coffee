answers = [
    'As I see it, yes.',
    'Ask again later.',
    'Better not tell you now.',
    'Cannot predict now.',
    'Concentrate and ask again.',
    'Don’t count on it.',
    'It is certain.',
    'It is decidedly so.',
    'Most likely.', 'My reply is no.',
    'My sources say no.', 'Outlook good.',
    'Outlook not so good.',
    'Reply hazy try again.',
    'Signs point to yes.',
    'Very doubtful.',
    'Without a doubt.',
    'Yes.',
    'Yes, definitely.',
    'You may rely on it.'
]


exports.command = (bot) ->
    bot.command "8ball", (msg, args) ->
        if args.length is 0
            bot.send msg,
                embeds: [
                    title: "You gotta tell me your question my guy."
                ]
            return
        bot.send msg,
            embeds: [
                title: answers[Math.floor(Math.random() * answers.length)]
            ]
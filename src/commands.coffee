enquirer     = require "enquirer"
fs           = require "fs"
yaml         = require "yaml"
chalk        = require "chalk"
terminal_kit = require "terminal-kit"
Utility      = (require "./ext/utils").Utility

utils = new Utility
term  = new terminal_kit.Terminal

class Commands
    constructor: ->
        @command_list = []
        @db           = utils.db
        @products     = @db.products
        @userdb       = @db.user_info

    information: (keys) ->
        unless keys.func?
            throw () -> "Function instance not found."
        keys.name ?= keys.func.name
        keys.desc ?= "Not specified"
        keys.usage ?= "Not specified"
        @command_list.push keys

    buy: (product) ->
        product = product.toLowerCase()
        if product is "list"
            list = [
                ["Product", "Price", "Attack", "Speed"]
            ]
            list.push [p.name, p.price, p.attack, p.speed] for _, p of @_products
            term.table list,
                hasBorder: true
                borderChars: 'lightRounded'
                width: 60
                fit: no

        else
            if product of @_products
                product = @_products[product]
                if product.price <= @_userdb.balance
                    @_userdb.balance -= product.price
                    utils.dump()
                    console.log chalk.green "Bought."
                else
                    console.log chalk.red "Not enough balance."
            else
                console.log chalk.red "Item not found. Try `buy list`."

    help: ->
        list = [
            ["Name", "Description", "Usage"]
        ]
        list.push [c.name, c.desc, c.usage] for c in @_commands
        term.table list,
            hasBorder: true
            borderChars: 'lightRounded'
            width: 60
            fit: no

    balance: ->
        console.log chalk.green @_userdb.balance

    exit: ->
        process.exit()

    ready: ->
        @information
            func: @buy
            desc: "Buy stuff from the store."
            _products: @products
            _db: @db
            _userdb: @userdb
        @information
            func: @help
            desc: "Shows this."
            _commands: @command_list
        @information
            func: @exit
            desc: "Exit from the script."
        @information
            func: @balance
            desc: "Shows your balance."
            _userdb: @userdb
        return true

exports.Commands = Commands
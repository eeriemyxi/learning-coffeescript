fs   = require "fs"
yaml = require "yaml"


class Database
    constructor: () ->
        @file = "./ext/data.yml"
        @db = yaml.parse fs.readFileSync @file, "utf-8"

    dump: () ->
        db = yaml.stringify(@db)
        fs.writeFileSync(@file, db, encoding: "utf-8")


class Utility extends Database
    constructor: () ->
        super()
        @STRIP_COMMENTS = /((\/\/.*$)|(\/\*[\s\S]*?\*\/))/mg
        @ARGUMENT_NAMES = /([^\s,]+)/g
    
    get_params: (func) ->
        fnStr = func.toString().replace(@STRIP_COMMENTS, '')
        result = fnStr.slice(fnStr.indexOf('(') + 1, fnStr.indexOf(')')).match(@ARGUMENT_NAMES)
        # if result == null
        #     result = []
        # result
        return if result is null then [] else result
    
exports.Utility = Utility
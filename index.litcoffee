    class Argv
     constructor: ->
      @name = 'A Node.Js Script'
      @params = []
      @check()
      @interpreter = process.argv[0]
      @script = process.argv[1]

     check: ->
      req = 0
      for p, i in @params when not p.default?
       req = i + 1

      if process.argv.length < 2 + req
       @usage()
       process.exit 1

      this

     setName: (name) ->
      @name = name
      this

     addParam: (id, name, def) ->
      @params.push
       id: id
       name: name
       default: def

      this

     getArgs: ->
      @check()

      args = {}
      for p, i in @params
       if process.argv.length > 2 + i
        args[p.id] = process.argv[2 + i]
       else
        args[p.id] = p.default

      args

     usage: ->
      console.log @name
      console.log '\nUsage'
      usage = " #{@interpreter} #{@script} "
      for p in @params
       usage += "#{p.id} "
      console.log usage

      console.log '\nParameters'
      for p in @params
       s = " #{p.id} - #{p.name}"
       if p.default?
        s += " default: #{p.default}"
       console.log s

      this

     getParam: (n) ->

    ARGV = new Argv

    module.exports = ARGV


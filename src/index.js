'use strict'

require('./index.html')

let Elm = require('./Main.elm')
let mountNode = document.getElementById('main')

let app = Elm.Main.embed(mountNode)

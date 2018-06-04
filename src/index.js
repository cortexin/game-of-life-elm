'use strict'

require('./index.html')
require('basscss/css/basscss.min.css')

let Elm = require('./Main.elm')
let mountNode = document.getElementById('main')

let app = Elm.Main.embed(mountNode)

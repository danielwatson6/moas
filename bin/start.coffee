#!/usr/bin/env node
app = require '../config/app'
db  = require '../config/db'

db()

port = process.env.PORT or 3000
app.set('port', port)

app.listen(port)
console.log "Listening on port %d", port

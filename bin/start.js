#!/usr/bin/env node
var app = require('../public/javascripts/config/app');

var port = process.env.PORT || 3000;
app.set('port', port);

app.listen(port);
console.log("Listening on port %d", port);

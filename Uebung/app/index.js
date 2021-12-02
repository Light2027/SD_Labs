const express = require('express')
const app = express()
 
app.get('/', function (_, res) {
  res.send('Hello World!')
})
 
const port = process.env.PORT || 8080;
app.listen(port, "", () => console.log(`Listening on ${port}`))

// This should not be a thing...
// The program itself should not have to be exported for testing...
module.exports = app;
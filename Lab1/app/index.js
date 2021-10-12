const express = require('express')
const app = express()
 
app.get('/', function (_, res) {
  res.send('Hello World')
})
 
const port = 8080;
app.listen(port, "", () => console.log(`Listening on ${port}`))

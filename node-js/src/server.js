const express = require("express")
const bodyParser = require("body-parser")
const server = express()
const port = 3000
const db = require("./queries")

server.use(bodyParser.json())



server.get ("/", (req, res) => {
    res.json({ info: "NodeJS ready!" })
})

server.get("/users", db.getUsers)

server.listen(port, () => console.log(`Server started on port ${port}.`))


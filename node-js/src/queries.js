const Pool = require("pg").Pool
const pool = new Pool({
    connectionString: process.env.DATABASE_URL
})

const getUsers = (req, res) => {
    pool.query('SELECT * FROM users ORDER BY id ASC', (error, results) => {
        if (error) {
            throw error
        }

        res.status(200).json(results.rows)
    })
}

module.exports = {getUsers}

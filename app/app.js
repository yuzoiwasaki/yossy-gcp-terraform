const express = require('express')
const mysql = require('mysql')
const app = express()
const port = 8080

const db = mysql.createConnection({
  host     : '10.10.0.3',
  user     : 'yuzo',
  password : 'password',
  database : 'maindb'
})

db.connect((err) => {
  if(err){
    throw err
  }

  console.log('MySQL Connected...')

  let sql = `CREATE TABLE IF NOT EXISTS users(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
  )`

  db.query(sql, (err, result) => {
    if(err) throw err
    console.log('User table created...')

    sql = `INSERT INTO users(name, email) VALUES
      ('John Doe', 'john@gmail.com'),
      ('Jane Doe', 'jane@gmail.com')`
    db.query(sql, (err, result) => {
      if(err) throw err
      console.log('Inserted dummy data...')
    })
  })
})

app.get('/', (req, res) => {
  let sql = 'SELECT * FROM users'
  let query = db.query(sql, (err, results) => {
    if(err) throw err
    res.send(results)
  })
})

app.listen(port, () => {
  console.log(`App running on http://localhost:${port}`)
})

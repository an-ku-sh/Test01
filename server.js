const express = require('express');
const cors = require('cors');
const app = express();

app.use(cors());

const books = [
  {id: 1, title: 'Alice in Wonderland', author: 'Lewis Carrol'},
  {id: 2, title: 'Around the World in eighty days', author: 'Jules Verne'},
  {id: 3, title: 'Utopia', author: 'Sir Thomas Moor'},
];

app.get('/api/books', (req, res) => {
  res.json(books);
});

app.listen(3000, () => {
  console.log('Server is running on port 3000');
});

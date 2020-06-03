
const express = require('express');
const app = express();
const cors = require('cors')
const PORT = process.env.PORT || 3000;

app.use(cors());


app.use(express.static('public'));

/* app.get('/', function (req, res) {
  res.send('Hello World!');
}); */

app.listen(PORT, function () {
  console.log('Listen in: ' + PORT);
});


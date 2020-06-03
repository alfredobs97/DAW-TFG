const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const encrypt = require('./encrypt');
const PORT = process.env.PORT || 3001;

app.use(bodyParser.json());

app.post('/encryptPass', async (req, res) => {
  const encryptedPass = await encrypt.encryptPass(req.body.pass);

  res.status(200).send(encryptedPass);
});

app.post('/decryptPass', async (req, res) => {
    const isCorrect = await encrypt.decryptPass(req.body.passPlain, req.body.passEncrypt);
  
    const statusCode = isCorrect ? 200 : 403;

    res.sendStatus(statusCode);
  });



app.listen(PORT, function() {
    console.log('Listen in:' + PORT);
});

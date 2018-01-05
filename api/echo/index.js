const restify = require('restify');

const name = process.env.NAME;
const port = process.env.PORT;

const server = restify.createServer({ name });

server.get(`/${name}/:data`, (req, res, next) => {
  console.log('sending back:', req.params.data);
  res.send(200, req.params.data);
});

server.listen(port, () => {
  console.log(`[${name}] listening on port: ${port}`);
});

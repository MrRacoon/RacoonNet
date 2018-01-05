const restify = require('restify');
const config = require('./package.json');

const server = restify.createServer({
  name: config.name,
});

server.get(`/${config.name}/:data`, (req, res, next) => {
  console.log('sending back:', req.params.data);
  res.send(200, req.params.data);
});

server.listen(config.port, () => {
  console.log('listening on port: ', config.port);
});

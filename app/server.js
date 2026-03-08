const express = require('express');
const app = express();

app.use(express.json());

app.get('/health', (req, res) => {
  res.json({
    status: 'ok',
    app: 'devdeploy',
    version: '1.0.0'
  });
});

app.get('/', (req, res) => {
  res.json({
    message: 'Welcome to DevDeploy!',
    deployed_by: 'Parshant'
  });
});

app.listen(80, () => console.log('DevDeploy running on port 80'));
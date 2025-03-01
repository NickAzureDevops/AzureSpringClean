const http = require('http');
const url = require('url');

// Vulnerability: Hardcoded API key
const apiKey = 'InstrumentationKey=248ccf4a-507c-4a7f-b392-0715dbe12cb7;IngestionEndpoint=https://uksouth-0.in.applicationinsights.azure.com/;LiveEndpoint=https://uksouth.livediagnostics.monitor.azure.com/;ApplicationId=8ad3e79d-5359-4635-872e-17664bf437b7';
const apiKey2 = 'sv=2021-10-04&si=azureml-system-datastore-policy&sr=c&sig=6qEkidd3POtYJspd1RdsQk44LldgtXuWPe%2BGiY%2FthB4%3D';



const server = http.createServer((req, res) => {
    const queryObject = url.parse(req.url, true).query;
    const name = queryObject.name || 'World';

    // Vulnerability: Using eval with user input
    const greeting = eval(`'Hello, ${name}!'`);

    res.writeHead(200, { 'Content-Type': 'text/plain' });
    res.end(greeting);
});

server.listen(3000, () => {
    console.log('Server running at http://localhost:3000/');
    console.log(`Using API Key: ${apiKey}`);
});



const http = require('http');
const url = require('url');

// Vulnerability: Hardcoded API key
const apiKey = '12345-ABCDE-SECRET-KEY';

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
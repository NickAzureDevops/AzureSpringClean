const http = require('http');
const url = require('url');

// Use environment variables for sensitive configuration
const apiKey = process.env.APPLICATION_INSIGHTS_KEY || '';
const apiKey2 = process.env.AZURE_STORAGE_SAS_TOKEN || '';

const server = http.createServer((req, res) => {
    const queryObject = url.parse(req.url, true).query;
    const name = queryObject.name || 'World';

    // Fixed: Use template literal instead of eval for performance and security
    const greeting = `Hello, ${name}!`;

    res.writeHead(200, { 'Content-Type': 'text/plain' });
    res.end(greeting);
});

server.listen(3000, () => {
    console.log('Server running at http://localhost:3000/');
    console.log(`API Key configured: ${apiKey ? 'Yes' : 'No'}`);
    console.log(`Storage SAS Token configured: ${apiKey2 ? 'Yes' : 'No'}`);
});



// A simple Hello World function with a vulnerability
function helloWorld(input) {
    // Vulnerable code: using eval to execute input
    eval("console.log('Hello, ' + input + '!')");
}

// Hardcoded secret in plain sight
const secret = "mySuperSecretPassword123";

// Example usage
helloWorld('World'); // This will print "Hello, World!" to the console

// Vulnerable usage
helloWorld('World; console.log("This is a vulnerability!")'); // This will execute the injected code

// Print the secret to demonstrate the vulnerability
console.log("The secret is: " + secret);
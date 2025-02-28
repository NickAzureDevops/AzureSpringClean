using System;

namespace HelloWorldApp
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");

            // Vulnerability: Hardcoded API key
            string apiKey = "12345-ABCDE-SECRET-KEY";

            // Vulnerability: Potential DoS attack by concatenating strings in a loop
            string input = "Hello";
            for (int i = 0; i < 10000; i++)
            {
                input = string.Concat(input, " World");
            }

            Console.WriteLine(input);
            Console.WriteLine($"Using API Key: {apiKey}");
        }
    }
}
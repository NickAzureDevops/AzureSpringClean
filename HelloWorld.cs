using System;

namespace VulnerableApp
{
    class Program
    {
        // Hardcoded secret in plain sight
        private const string Secret = "mySuperSecretPassword123";

        static void Main(string[] args)
        {
            // Example usage
            HelloWorld("World"); // This will print "Hello, World!" to the console

            // Vulnerable usage
            HelloWorld("World; Console.WriteLine(\"This is a vulnerability!\")"); // This will execute the injected code

            // Print the secret to demonstrate the vulnerability
            Console.WriteLine("The secret is: " + Secret);
        }

        // A simple Hello World function with a vulnerability
        static void HelloWorld(string input)
        {
            // Vulnerable code: using C#'s eval equivalent to execute input
            Microsoft.CSharp.CSharpCodeProvider provider = new Microsoft.CSharp.CSharpCodeProvider();
            System.CodeDom.Compiler.CompilerParameters parameters = new System.CodeDom.Compiler.CompilerParameters();
            parameters.GenerateInMemory = true;
            System.CodeDom.Compiler.CompilerResults results = provider.CompileAssemblyFromSource(parameters, @"
                using System;
                public class DynamicCode
                {
                    public void Execute()
                    {
                        " + input + @"
                    }
                }");

            if (results.Errors.Count == 0)
            {
                object o = results.CompiledAssembly.CreateInstance("DynamicCode");
                o.GetType().GetMethod("Execute").Invoke(o, null);
            }
            else
            {
                Console.WriteLine("Error compiling code");
            }
        }
    }
}
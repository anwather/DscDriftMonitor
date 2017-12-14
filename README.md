# Introduction 
Monitor DSC for drift when the LCM configuration mode is set to ApplyandAutoCorrect 

# Getting Started
TODO: Guide users through getting your code up and running on their own system. In this section you can talk about:
1.	Installation process
2.	Software dependencies
3.	Latest releases
4.	API references

# Build and Test
TODO: Describe and show how to build your code and run the tests. 

# Contribute
TODO: Explain how other users and developers can contribute to make your code better. 

If you want to learn more about creating good readme files then refer the following [guidelines](https://www.visualstudio.com/en-us/docs/git/create-a-readme). You can also seek inspiration from the below readme files:
- [ASP.NET Core](https://github.com/aspnet/Home)
- [Visual Studio Code](https://github.com/Microsoft/vscode)
- [Chakra Core](https://github.com/Microsoft/ChakraCore)

# Plan

- Check for xDSCDiagnostics module
- Turn on analytic event log and set size
- Get current job using get-dscconfigurationstatus **Doesnt work** (uses the LCM)
- Get the current job from the most recent log
- Search for Start Set
- Write to event log

- watermark in registry for event log checking
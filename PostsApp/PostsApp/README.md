# Overview

It is obvious that in a cross-functional team setup, it is important to have a modular architecture that enables code re-use and allows concurrent feature development with out enforcing all developers to depend/wait for a specific implementation. 

This sample App is segmented in to different independent modules. Coordinator, Network and Logger modules are utility modules that can be used individually by any other module. For example, “LoginModule” may depend on Coordinator, Network and Logger modules directly or they can be injected (after initialising) in to Login Module by its super module (an App).

In this way, every feature module can have its own architecture and its own development team. Also, every module may have its own example App that can be used by developers for development. One of the challenges that we face in such a setup is, how can we integrate all these modules/dependancies in to the final App, the so called Dependancy Management.

There are several options, each having its own pros and cons. 
1. Manual linking
2. Cocoapods
3. Swift Package Manager
4. Git Subtree
5. Git Submodule
6. Other 3rd party extensions

But, the dependency manager may not be sufficient, as we don’t want to include the complete sub-project sources or as a framework in to our main repository but only the essential source files compiled in to the main App binary. For example, using a pre-build script to include the necessary files in to the App target.


# Requirements

Xcode Version 11+ Swift 5.0+
No 3rd party frameworks has been used in this project. 


# Architecture


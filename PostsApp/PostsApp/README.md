# PostsApp Implementation Description

The master branch and develop branch have different states with master branch having a single project with necessary sources and the develop branch having sources splitted in to 3 different projects(sub) that will automatically build and also run tests.

## Master Branch

For the sake of demonstration, I have divided this project in to 3 different xcode projects each for Main App, PostsFeature and Utilities.

1. "Main App(PostsApp) module" consists of necessary resources and configuration and also Login (currently, there is nothing for Login to implement, so didn't separate it for now).
2. "PostsFeature module" consists of every thing what PostsFeature needs and will be configured by Main App as needed.
3. "Utilities module" consists of the necessary dependancies required by most of the modules in the App like Networking, Coordinators, Logging etc.


## Develop Branch

While the master branch displays how the setup can be splitted in to multiple projects to enabble scalability, the develop branch shows how the project can be modularised using a single project. 


## Installation

As I have used no external frameworks for development, it is possible to download the app from the repository, build it and run.

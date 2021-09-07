# ios-template

An iOS project template to kickstart your project with CleanArchitecture with MVVM+Coordinator.

### Prerequisites:
* [XcodeGen](https://github.com/yonaskolb/XcodeGen/blob/master/Docs/ProjectSpec.md#dependency)


[Install Xcodegen](https://github.com/yonaskolb/XcodeGen#installing) by running below terminal command or suitable methods.

```
brew install xcodegen
```

## Usage


### Create new repository from this template

You can create new repository direcly from this Github template project. follow the instructions to create new project is given **[here](https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/creating-a-repository-on-github/creating-a-repository-from-a-template)**.


### Clone the newly created repository

Open Terminal.

1. Change the current working directory to the location where you want the cloned directory.
2. Type git clone, and then paste the URL you copied earlier.
3. `$ git clone https://github.com/YOUR-USERNAME/YOUR-REPOSITORY`


### Editing `project.yml`

1. find `#FIXME` comments
2. Replace the text of REPLACE_PROJECT_NAME with your desired project name e.g. YOUR_PROJECT_NAME
3. Replace the text of REPLACE_BUNDLE_ID_PREFIX with your desired project name e.g. REPLACE_BUNDLE_ID_PREFIX

### Run `Xcodegen` command 

Now just type `xcodegen` in terminal and return. This will create xcode project with  *YOUR_PROJECT_NAME.xcodeproj*. 

```shell
$ xcodegen
⚙️  Generating plists...
⚙️  Generating project...
⚙️  Writing project...
Created project at /Users/Aarif_Sumra/Developer/Github/GitHub/monstar-lab-oss/ios-template/YOUR_PROJECT_NAME.xcodeproj
```

Now open it from command or using finder.
```shell
$ open YOUR_PROJECT_NAME.xcodeproj
```

You are done! 


## 👥 Credits
Made with ❤️ at Monstarlab

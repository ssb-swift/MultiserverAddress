# MultiserverAddress

Define valid multiserver addresses. | _[multiserver-address][ref]_

### [Documentation][wiki]

## Install

Add the following to the Package.swift dependencies:

```swift
.package(url: "https://github.com/ssb-swift/MultiserverAddress", from: "1.0.0")

...

.product(name: "MultiserverAddress", package: "MultiserverAddress")
```

[Or add the package in Xcode.][xcode-package-management-guide]

## Contributing

### swift-format

This project uses [swift-format][swift-format] for automatic code formatting as a pre-commit hook; Use the following instructions to set up swift-format for your environment:

**Install swift-format**
```sh
cd <repository-location>
git clone -b swift-5.4-branch https://github.com/apple/swift-format.git
cd swift-format
swift build
```

**Add switf-format to your PATH**
```sh
export PATH=$PATH:~/<repository-location>/swift-format/.build/x86_64-apple-macosx/debug
```
_Don't forget to reload your Terminal configuration._

**Create the Git hook**

* Create the _pre-commit_ file in the project's `.git/hooks` directory.
```sh
touch .git/hooks/pre-commit
```
* Give the file execution rights:
```sh
sudo chmod +x .git/hooks/pre-commit
```
* Add the following script to the _pre-commit_ file and save the changes:
```sh
#!/bin/bash
swift-format --version 1>/dev/null 2>&1
if [ $? -eq 0 ]
then
    git diff --diff-filter=d --staged --name-only | grep -e '\(.*\).swift$' | while read line; do
        swift-format -i "${line}";
        git add "$line";
    done
fi
```

Now, every time you commit new changes in the project, swift-format will automatically format them before committing them.

[wiki]: https://github.com/ssb-swift/multiserver-address/wiki
[ref]: https://github.com/ssbc/multiserver-address
[swift-format]: https://github.com/apple/swift-format
[xcode-package-management-guide]: https://developer.apple.com/documentation/swift_packages/adding_package_dependencies_to_your_app


## Table of Contents

* [About the Project](#about-the-project)
  * [Built With](#built-with)
* [Getting Started](#getting-started)
  * [Installation](#installation)
* [Contributing](#contributing)
* [License](#license)
* [Contact](#contact)

## About The Project

The project essentially is another try to learn OpenGL hence the name `YetAnother`. The goal is to explore OpenGL using http://www.swiftgl.org/.

### Built With
* [Swift GLFW3](https://github.com/SwiftGL/CGLFW3)
* [OpenGL Swift Loader](https://github.com/SwiftGL/OpenGL)

## Getting Started
### Prerequisites

* GLFW3

OpenGL has no facility to open windows or create a context it can draw to. This is an intentional design choice and not an oversight. We’ll be using GLFW, a cross-platform library, written in C, specifically targeted at OpenGL providing the bare necessities required for rendering goodies to the screen. It allows us to create an OpenGL context, define window parameters, and handle user input.

```bash
brew install glfw3
```

### Installation

1. Clone the repo
```sh
git clone https://github.com/pkondrashkov/YetAnotherSwiftGL.git
```
3. Generate Xcode Project
```sh
swift package generate-xcodeproj --xcconfig-overrides ./Package.xcconfig
```
4. Run `main` target in Xcode

## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

Distributed under the MIT License. See `LICENSE` for more information.

## Contact

Pavel Kondrashkov - [@pkondrashkov](https://twitter.com/pkondrashkov) - pkondrashkov@gmail.com

Project Link: [https://github.com/pkondrashkov/YetAnotherSwiftGL](https://github.com/pkondrashkov/YetAnotherSwiftGL)

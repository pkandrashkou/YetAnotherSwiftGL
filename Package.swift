// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "main",
    dependencies: [
        .package(url: "https://github.com/SwiftGL/OpenGL.git", from: "3.1.1"),
        .package(url: "https://github.com/SwiftGL/Math.git", from: "3.0.0"),
        .package(url: "https://github.com/SwiftGL/Image.git", from: "2.2.0")
    ]
)

#if os(Linux)
    package.dependencies.append(
        .package(url: "https://github.com/SwiftGL/CGLFW3Linux.git", from: "1.0.1")
        // If your distro renamed the library to "glfw" (no 3) use this instead:
        // package.Dependency.package(url: "https://github.com/SwiftGL/CGLFWLinux.git", majorVersion: 1)
    )
#else
    package.dependencies.append(
        .package(url: "https://github.com/pkondrashkov/CGLFW3.git", .branch("master"))
    )
#endif
import PackageDescription

let package = Package(
    name: "main",
    dependencies: [
        .Package(url: "https://github.com/SwiftGL/OpenGL.git", majorVersion: 3),
        .Package(url: "https://github.com/SwiftGL/Math.git", majorVersion: 2),
        .Package(url: "https://github.com/SwiftGL/Image.git", majorVersion: 2)
    ]
)

#if os(Linux)
    package.dependencies.append(
        Package.Dependency.Package(url: "https://github.com/SwiftGL/CGLFW3Linux.git", majorVersion: 1)
        // If your distro renamed the library to "glfw" (no 3) use this instead:
        // Package.Dependency.Package(url: "https://github.com/SwiftGL/CGLFWLinux.git", majorVersion: 1)
    )
#else
    package.dependencies.append(
        Package.Dependency.Package(url: "https://github.com/SwiftGL/CGLFW3.git", majorVersion: 2)
    )
#endif
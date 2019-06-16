//
//  main.swift
//  YetAnotherSwiftGL
//
//  Created by Pavel Kondrashkov on 6/15/19.
//  Copyright © 2019 pkondrashkov. All rights reserved.
//

import CGLFW3
import SGLOpenGL

struct Configuration {
    static let width: GLsizei = 800
    static let height: GLsizei = 600
}

func main() {
    glfwInit()
    defer { glfwTerminate() }

    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3)
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3)
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE)
    glfwWindowHint(GLFW_RESIZABLE, GL_FALSE)
    glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE)

    let window = glfwCreateWindow(Configuration.width, Configuration.height, "LearnSwiftGL", nil, nil)
    glfwMakeContextCurrent(window)
    guard window != nil else {
        print("Failed to create GLFW window")
        return
    }

    while glfwWindowShouldClose(window) == GL_FALSE {
        glfwPollEvents()

        glClearColor(red: 0.2, green: 0.3, blue: 0.3, alpha: 1.0)
        glClear(GL_COLOR_BUFFER_BIT)

        glfwSwapBuffers(window)
    }

}

main()

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

let vertices:[GLfloat] = [
    0.5,  0.5, 0.0,  // Top Right
    0.5, -0.5, 0.0,  // Bottom Right
    -0.5, -0.5, 0.0,  // Bottom Left
    -0.5,  0.5, 0.0   // Top Left
]
let indices:[GLuint] = [  // Note that we start from 0!
    0, 1, 3,  // First Triangle
    1, 2, 3   // Second Triangle
]

let vertexShaderSource =
"""
#version 330 core

layout (location = 0) in vec3 position;

void main()
{
    gl_Position = vec4(position.x, position.y, position.z, 1.0);
}
"""

let fragmentShaderSource =
"""
#version 330 core

out vec4 color;

void main()
{
color = vec4(1.0f, 0.5f, 0.2f, 1.0f);
}
"""


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

    glfwSetKeyCallback(window, keyCallback)
    glViewport(x: 0, y: 0, width: Configuration.width, height: Configuration.height)

    /// Enable to draw lines
    glPolygonMode(GL_FRONT_AND_BACK, GL_LINE)

    var VAO: GLuint = 0
    glGenVertexArrays(1, &VAO)
    defer { glDeleteVertexArrays(1, &VAO)}
    glBindVertexArray(VAO)

    var EBO: GLuint = 0
    glGenBuffers(n: 1, buffers: &EBO)
    defer { glDeleteBuffers(1, &EBO) }
    glBindBuffer(target: GL_ELEMENT_ARRAY_BUFFER, buffer: EBO)
    glBufferData(target: GL_ELEMENT_ARRAY_BUFFER,
                 size: MemoryLayout<GLuint>.stride * indices.count,
                 data: indices, usage: GL_STATIC_DRAW)

    var VBO: GLuint = 0
    glGenBuffers(n: 1, buffers: &VBO)
    defer { glDeleteBuffers(1, &VBO) }
    glBindBuffer(target: GL_ARRAY_BUFFER, buffer: VBO)
//    MemoryLayout<GLfloat>.size
    glBufferData(target: GL_ARRAY_BUFFER,
                 size: MemoryLayout<GLfloat>.stride * vertices.count,
                 data: vertices, usage: GL_STATIC_DRAW)

    let vertexShader: GLuint = glCreateShader(type: GL_VERTEX_SHADER)
    vertexShaderSource.withCString {
        var s = [$0]
        glShaderSource(shader: vertexShader, count: 1, string: &s, length: nil)
    }
    glCompileShader(vertexShader)
    checkShaderCompile(shader: vertexShader)

    let fragmentShader: GLuint = glCreateShader(type: GL_FRAGMENT_SHADER)
    fragmentShaderSource.withCString {
        var s = [$0]
        glShaderSource(shader: fragmentShader, count: 1, string: &s, length: nil)
    }
    glCompileShader(fragmentShader)
    checkShaderCompile(shader: fragmentShader)

    let shaderProgram: GLuint = glCreateProgram()
    glAttachShader(shaderProgram, vertexShader)
    glAttachShader(shaderProgram, fragmentShader)
    glLinkProgram(shaderProgram)
    checkProgramCompile(program: shaderProgram)

    glDeleteShader(vertexShader)
    glDeleteShader(fragmentShader)


    glVertexAttribPointer(0, 3, GL_FLOAT, false, GLsizei(MemoryLayout<GLfloat>.stride * 3), nil)
    glEnableVertexAttribArray(0)
    glBindVertexArray(0)



    while glfwWindowShouldClose(window) == GL_FALSE {
        glfwPollEvents()

        glClearColor(red: 0.2, green: 0.3, blue: 0.3, alpha: 1.0)
        glClear(GL_COLOR_BUFFER_BIT)

        glUseProgram(shaderProgram)
        glBindVertexArray(VAO)
//        glDrawArrays(GL_TRIANGLES, 0, 3)
        glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, nil)
        glBindVertexArray(0)


        glfwSwapBuffers(window)
    }

}

func checkShaderCompile(shader: GLuint) {
    var success: GLint = 0
    glGetShaderiv(shader, GL_COMPILE_STATUS, &success)
    var infoLog = [GLchar](repeating: 0, count: 512)
    guard success == GL_TRUE else {
        glGetShaderInfoLog(shader, 512, nil, &infoLog)
        fatalError(String(cString: infoLog))
    }
}

func checkProgramCompile(program: GLuint) {
    var success: GLint = 0
    glGetProgramiv(program, GL_LINK_STATUS, &success)
    var infoLog = [GLchar](repeating: 0, count: 512)
    guard success == GL_TRUE else {
        glGetProgramInfoLog(program, 512, nil, &infoLog)
        fatalError(String(cString: infoLog))
    }
}


func keyCallback(window: OpaquePointer?, key: Int32, scancode: Int32, action: Int32, mode: Int32) {
    if (key == GLFW_KEY_ESCAPE && action == GLFW_PRESS) {
        glfwSetWindowShouldClose(window, GL_TRUE)
    }
}

main()

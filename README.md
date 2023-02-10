#  C++ Conan example 1

Build steps to follow: 

## Windows with Visual Studio:
    cd examples/libraries/dear-imgui/basic
    mkdir build
    cd build
    conan install .. -s build_type=Release 
    #Add below parameters if above fails
    #-r {{repo_name}} --build=missing 
    conan install .. -s build_type=Debug
    cmake .. -G "Visual Studio 16 2019" -A "x64"
    cmake --build . --config Release
    cd Release
    dear-imgui-conan

## Linux:
    cd examples/libraries/dear-imgui/basic
    mkdir build
    cd build
    conan install .. -s build_type=Release
    cmake .. -DCMAKE_BUILD_TYPE=Release
    cmake --build .
    ./dear-imgui-conan

> See [here](https://github.com/axel-op/vscode-containerdevelopment-cpp-vcpkg) for a similar example with vcpkg

This template demonstrates how to build and execute a C++ program inside a container.

All the C++ related VSCode extensions are defined in the [`devcontainer.json`](./.devcontainer/devcontainer.json) file and are automatically installed with the container.

## How to use it

You need to have [Visual Studio Code](https://code.visualstudio.com/) and the [Remote Development extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack) installed on your computer.

Open the `.cpp` file to debug, then press F5 to launch the instructions defined in [`launch.json`](./.vscode/launch.json).

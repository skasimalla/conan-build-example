cmake_minimum_required(VERSION 3.15)
project(Example)

find_package(ZLIB REQUIRED)

add_executable(${PROJECT_NAME} src/Example.cpp)
target_link_libraries(${PROJECT_NAME} ZLIB::ZLIB)

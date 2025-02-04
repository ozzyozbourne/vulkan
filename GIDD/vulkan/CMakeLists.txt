cmake_minimum_required(VERSION 3.30.0)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
project(VulkanTest VERSION 0.0.1 LANGUAGES CXX)

set(CMAKE_CXX_COMPILER clang++)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_compile_options(-Wall -Wextra -Wpedantic)

find_package(Vulkan REQUIRED)
find_package(glfw3 REQUIRED)
find_package(glm REQUIRED)

add_executable(${PROJECT_NAME} main.cpp)

target_include_directories(${PROJECT_NAME} PRIVATE
    ${Vulkan_INCLUDE_DIRS}
    /opt/homebrew/Cellar/glfw/3.4/include
    /opt/homebrew/Cellar/glm/1.0.1/include
)

target_link_directories(${PROJECT_NAME} PRIVATE 
    ${Vulkan_LIBRARY_DIRS}
    /opt/homebrew/Cellar/glfw/3.4/lib
    /opt/homebrew/Cellar/glm/1.0.1/lib
)

target_link_libraries(${PROJECT_NAME} PRIVATE 
    Vulkan::Vulkan
    glfw
    glm::glm
)



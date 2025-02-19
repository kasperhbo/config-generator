cmake_minimum_required(VERSION 3.10)
project(Renderer)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
if (NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug CACHE STRING "" FORCE)
endif ()

#DEFAULTS
# To enable debugging info
set(CMAKE_BUILD_TYPE Debug)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DVK_PROTOTYPES")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DVK_PROTOTYPES")


# Directories for ImGui and Glad
set(IMGUI_DIR ${CMAKE_SOURCE_DIR}/lib/imgui)
set(GLAD_DIR ${CMAKE_SOURCE_DIR}/lib/glad/include)
set(NLOHMANN_JSON_DIR ${CMAKE_SOURCE_DIR}/lib/nlohmann)

# Add ImGui and Glad sources
set(SOURCES
        src/main.cpp
        ${IMGUI_DIR}/imgui.cpp
        ${IMGUI_DIR}/imgui_demo.cpp
        ${IMGUI_DIR}/imgui_draw.cpp
        ${IMGUI_DIR}/imgui_tables.cpp
        ${IMGUI_DIR}/imgui_widgets.cpp
        ${IMGUI_DIR}/backends/imgui_impl_glfw.cpp
        ${IMGUI_DIR}/backends/imgui_impl_vulkan.cpp

        ${NLOHMANN_JSON_DIR}/json.hpp
        ${NLOHMANN_JSON_DIR}/json_fwd.hpp

        ${CMAKE_SOURCE_DIR}/lib/glad/src/glad.c

        src/Core/Application.cpp
)


add_executable(Renderer ${SOURCES})
target_include_directories(Renderer PRIVATE ${IMGUI_DIR})
target_include_directories(Renderer PRIVATE ${GLAD_DIR})
target_include_directories(Renderer PRIVATE ${NLOHMANN_JSON_DIR})


# Libraries
find_package(Vulkan REQUIRED)
target_link_libraries(Renderer PRIVATE Vulkan::Vulkan)

# GLFW
if (APPLE)
    # MacOS
    message(STATUS "Building for Mac OS X")
    set(GLFW_INCLUDE_DIR /opt/homebrew/opt/glfw/include)
    set(GLFW_LIBRARY_DIR /opt/homebrew/opt/glfw/lib)
    target_include_directories(Renderer PRIVATE
            /usr/local/include
            /opt/local/include
            /opt/homebrew/include ${GLFW_INCLUDE_DIR})
    target_link_libraries(Renderer PRIVATE
            "-L${GLFW_LIBRARY_DIR}"
            "-framework OpenGL"
            "-framework Cocoa"
            "-framework IOKit"
            "-framework CoreVideo" glfw)
else ()
    MESSAGE(FATAL_ERROR "Only Mac OS X is supported at the moment!!")
endif ()



# Clean targets
add_custom_target(clean-all
        COMMAND ${CMAKE_COMMAND} -E remove -f ${CMAKE_BINARY_DIR}/Renderer
        COMMAND ${CMAKE_COMMAND} -E remove -f ${CMAKE_BINARY_DIR}/*.o
        COMMENT "Clean build directory"
)

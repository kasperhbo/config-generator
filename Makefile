
# Cross Platform Makefile for MSYS2/MINGW, Ubuntu, Mac OS X
# Requires GLFW (http://www.glfw.org):
# Linux: apt-get install libglfw-dev
# Mac OS X: brew install glfw
# MSYS2: pacman -S --noconfirm --needed mingw-w64-x86_64-toolchain mingw-w64-x86_64-glfw

EXE = Renderer
IMGUI_DIR = ./lib/imgui
GLAD_DIR = ./lib/glad/include
SOURCES = ./src/main.cpp \
          $(IMGUI_DIR)/imgui.cpp $(IMGUI_DIR)/imgui_demo.cpp $(IMGUI_DIR)/imgui_draw.cpp \
          $(IMGUI_DIR)/imgui_tables.cpp $(IMGUI_DIR)/imgui_widgets.cpp \
          $(IMGUI_DIR)/backends/imgui_impl_glfw.cpp $(IMGUI_DIR)/backends/imgui_impl_opengl3.cpp \
          ./lib/glad/src/glad.c

CXX_SOURCES = $(filter %.cpp, $(SOURCES))
C_SOURCES = $(filter %.c, $(SOURCES))
CXX_OBJS = $(CXX_SOURCES:.cpp=.o)
C_OBJS = $(C_SOURCES:.c=.o)
OBJS = $(CXX_OBJS) $(C_OBJS)
UNAME_S := $(shell uname -s)

CXXFLAGS = -std=c++11 -g -Wall -Wformat -I$(IMGUI_DIR) -I$(IMGUI_DIR)/backends -I$(GLAD_DIR)
CFLAGS = -g -Wall 
LIBS =

# Build for different platforms
ifeq ($(UNAME_S), Linux)
  ECHO_MESSAGE = "Linux"
  LIBS += `pkg-config --static --libs glfw3` -lGL
  CXXFLAGS += `pkg-config --cflags glfw3`
endif

ifeq ($(UNAME_S), Darwin)
  ECHO_MESSAGE = "Mac OS X"
  
  GLFW_INC_DIR := /opt/homebrew/opt/glfw/include
  GLFW_LIB_DIR := /opt/homebrew/opt/glfw/lib

  LIBS += -L$(GLFW_LIB_DIR) -framework OpenGL -framework Cocoa -framework IOKit -framework CoreVideo -lglfw
  CXXFLAGS += -I/usr/local/include -I/opt/local/include -I/opt/homebrew/include -I$(GLFW_INC_DIR)
endif

ifeq ($(OS), Windows_NT)
  ECHO_MESSAGE = "MinGW"
  LIBS += -lglfw3 -lgdi32 -lopengl32 -limm32
  CXXFLAGS += `pkg-config --cflags glfw3`
endif

# Build rules
%.o: %.cpp
	g++ $(CXXFLAGS) -c $< -o $@

%.o: %.c
	gcc $(CFLAGS) -I ./lib/glad/include -c $< -o $@

all: $(EXE)
	@echo Build complete for $(ECHO_MESSAGE)

$(EXE): $(OBJS)
	g++ $^ -o $@ $(LIBS)

exec: $(EXE)
	./$(EXE)

clean:
	rm -f $(EXE) $(OBJS)

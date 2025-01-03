# Cross Platform Makefile for MSYS2/MINGW, Ubuntu, Mac OS X
# Requires GLFW (http://www.glfw.org):
# Linux: apt-get install libglfw-dev
# Mac OS X: brew install glfw
# MSYS2: pacman -S --noconfirm --needed mingw-w64-x86_64-toolchain mingw-w64-x86_64-glfw

EXE = Renderer
IMGUI_DIR = ../imgui
SOURCES = main.cpp \
          $(IMGUI_DIR)/imgui.cpp $(IMGUI_DIR)/imgui_demo.cpp $(IMGUI_DIR)/imgui_draw.cpp \
          $(IMGUI_DIR)/imgui_tables.cpp $(IMGUI_DIR)/imgui_widgets.cpp \
          $(IMGUI_DIR)/backends/imgui_impl_glfw.cpp $(IMGUI_DIR)/backends/imgui_impl_opengl3.cpp

OBJS = $(SOURCES:.cpp=.o)
UNAME_S := $(shell uname -s)

CXXFLAGS = -std=c++11 -g -Wall -Wformat -I$(IMGUI_DIR) -I$(IMGUI_DIR)/backends
LIBS =

# Build for different platforms
ifeq ($(UNAME_S), Linux)
  ECHO_MESSAGE = "Linux"
  LIBS += `pkg-config --static --libs glfw3` -lGL
  CXXFLAGS += `pkg-config --cflags glfw3`
endif

ifeq ($(UNAME_S), Darwin)
  ECHO_MESSAGE = "Mac OS X"
  LIBS += -framework OpenGL -framework Cocoa -framework IOKit -framework CoreVideo -lglfw
  CXXFLAGS += -I/usr/local/include -I/opt/local/include -I/opt/homebrew/include
endif

ifeq ($(OS), Windows_NT)
  ECHO_MESSAGE = "MinGW"
  LIBS += -lglfw3 -lgdi32 -lopengl32 -limm32
  CXXFLAGS += `pkg-config --cflags glfw3`
endif

# Build rules
%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

all: $(EXE)
	@echo Build complete for $(ECHO_MESSAGE)

$(EXE): $(OBJS)
	$(CXX) $^ -o $@ $(CXXFLAGS) $(LIBS)

exec: $(EXE)
	./$(EXE)

clean:
	rm -f $(EXE) $(OBJS)


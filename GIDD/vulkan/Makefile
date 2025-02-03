CFLAGS = -std=c++23 -Wall -Wextra -Wpedantic

COMM = /opt/homebrew/Cellar

LDFLAGS = -lvulkan -lglfw -lglm -L$(VULKAN_SDK)/lib -L$(COMM)/glfw/3.4/lib -L$(COMM)/glm/1.0.1/lib
IFLAGS = -I$(VULKAN_SDK)/include -I$(COMM)/glfw/3.4/include

.PHONY: build
build: 
	clang++ $(CFLAGS) -o VulkanTest main.cpp $(IFLAGS) $(LDFLAGS)

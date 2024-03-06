CFLAGS = -std=c++20 -O2
LDFLAGS =  -lvulkan.1 -lvulkan.1.3.275 -lglfw 

.PHONY:	build

build: clean
	g++ $(CFLAGS) -o VulkanTest  main.cpp  $(LDFLAGS)

clean: main.cpp
	rm -f VulkanTest

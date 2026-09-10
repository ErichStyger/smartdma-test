all:
	echo "use target 'clean' or 'build'"

clean:
	rm hello.elf

build:
	arm-none-eabi-gcc -O0 -g hello.c -o hello.elf -specs=rdimon.specs -lc -lrdimon -lnosys -static

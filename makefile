all:
	echo "use target 'clean', 'build' or `run`"

clean:
	rm hello.elf

build:
	arm-none-eabi-gcc -O0 -g main.c -o hello.elf -specs=rdimon.specs -lc -lrdimon -lnosys -static

run:
	../qemu/build/qemu-system-arm -M versatilepb -nographic -semihosting -kernel hello.elf -audio driver=none



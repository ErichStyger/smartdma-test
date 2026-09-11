all:
	echo "use target 'clean', 'build' or `run`"

clean:
	rm -f hello.elf

build:
	arm-none-eabi-gcc -O0 -g main.c -o hello.elf -specs=rdimon.specs -lc -lrdimon -lnosys -static

run:
	../qemu/build/qemu-system-arm -audio driver=none -M versatilepb -nographic -semihosting -kernel hello.elf

buildcmake:
	cmake --preset Debug
	cmake --build --preset app-debug

runcmake:
	../qemu/build/qemu-system-arm -audio driver=none -M versatilepb -nographic -semihosting -kernel build/Debug/quemutest.elf
	

all:
	echo "use target 'clean', 'build' or `run`"

clean:
	rm -f hello.elf

build:
	arm-none-eabi-gcc -O0 -g main.c -o hello.elf -specs=rdimon.specs -lc -lrdimon -lnosys -static

run:
	../qemu/build/qemu-system-arm -audio driver=none -M versatilepb -nographic -semihosting -kernel hello.elf

cmakebuild:
	cmake --preset Debug
	cmake --build --preset app-debug --target clean
	cmake --build --preset app-debug

cmakerun:
	../qemu/build/qemu-system-arm -audio driver=none -M versatilepb -nographic -semihosting -kernel build/Debug/qemutest.elf


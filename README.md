# SmartDMA Test
Project testing SmartDMA with QEMU.

## Build
```
make build
```

## Run
```
../qemu/build/qemu-system-arm -M versatilepb -nographic -semihosting -kernel hello.elf -audio driver=none
```

## CMake
To list the presets:
```
cmake --list-presets
```

To configure the project:
```
cmake --preset Debug
```

Build:
```
cmake --build --preset app-debug
```

## GDB
arm-none-eabi-gdb build/Debug/qemutest.elf

target remote :1234

info registers
x/8wx 0x00000000

break Reset_Handler
break main

continue
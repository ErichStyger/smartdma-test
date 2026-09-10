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
or
```
cmake --preset Release
```

Build:
```
cmake --build --preset app-debug
```


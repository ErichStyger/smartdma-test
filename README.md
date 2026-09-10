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

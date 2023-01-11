make run
arm-linux-gnueabihf-gcc -mcpu=cortex-a72 -o example.bin example.s sysyruntimelibrary/libsysy.a
qemu-arm -L /usr/arm-linux-gnueabihf example.bin
echo $?
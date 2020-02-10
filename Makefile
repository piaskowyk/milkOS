compiler_path = ./gcc-arm/bin
source_path = ./src
build_path = ./bin

run: build
	qemu-system-arm -m 256 -M raspi2 -serial stdio -kernel $(build_path)/milkOS.elf

build:
	$(compiler_path)/arm-none-eabi-gcc -mcpu=cortex-a7 -fpic -ffreestanding -c $(source_path)/boot.S -o $(build_path)/boot.o
	$(compiler_path)/arm-none-eabi-gcc -mcpu=cortex-a7 -fpic -ffreestanding -std=gnu99 -c $(source_path)/kernel.c -o $(build_path)/kernel.o -O2 -Wall -Wextra
	$(compiler_path)/arm-none-eabi-gcc -T $(source_path)/linker.ld -o $(build_path)/milkOS.elf -ffreestanding -O2 -nostdlib $(build_path)/boot.o $(build_path)/kernel.o
	$(compiler_path)/arm-none-eabi-objcopy $(build_path)/milkOS.elf -O binary $(build_path)/milkOS.bin

clean:
	rm $(build_path)/*.o
	rm $(build_path)/*.bin
	rm $(build_path)/*.elf
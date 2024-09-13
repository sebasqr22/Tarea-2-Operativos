boot_SRC = boot.asm
MYNAME_SRC = myname.asm
boot_BIN = boot.bin
MYNAME_BIN = myname.bin
IMAGE_BIN = boot_image.bin

ASM = nasm
ASM_FLAGS = -f bin
EMU = qemu-system-x86_64

all: $(IMAGE_BIN)

$(boot_BIN): $(boot_SRC)
	$(ASM) $(ASM_FLAGS) $< -o $@

$(MYNAME_BIN): $(MYNAME_SRC)
	$(ASM) $(ASM_FLAGS) $< -o $@

$(IMAGE_BIN): $(boot_BIN) $(MYNAME_BIN)
	cat $(boot_BIN) $(MYNAME_BIN) > $(IMAGE_BIN)

run: $(IMAGE_BIN)
	$(EMU) -drive format=raw,file=$(IMAGE_BIN)

clean:
	rm -f $(boot_BIN) $(MYNAME_BIN) $(IMAGE_BIN)

run2:
	rm -rf build
	mkdir build
	nasm -f bin boot.asm -o build/boot.bin
	nasm -f bin myname.asm -o build/myname.bin

	dd if=build/boot.bin of=build/app.img bs=512 count=1
	dd if=build/myname.bin of=build/app.img bs=512 count=8 seek=1
	
	sudo xxd build/app.img

	qemu-system-x86_64 -fda build/app.img
	

burn:
	sudo dd if=/dev/zero of=/dev/sdb count=16000 bs=512
	sudo dd if=build/app.img of=/dev/sdb
	sudo xxd -s 0 -l 0x1200 /dev/sdb
	
	
checkUSB:
	ls -l /dev/disk/by-id/*usb*

RUSTC		= rustc
SRC			= ./src
BIN			= ./bin
IMG			= ./img
OPT			= --target arm-unknown-linux-gnueabihf --emit=obj
OUTPUT		= kernel32

default:
	mkdir -p $(BIN)
	$(RUSTC) $(OPT) $(SRC)/$(OUTPUT).rs --out-dir $(BIN)

install:
	mkdir -p $(IMG)
	arm-none-eabi-gcc -O2 -mfpu=vfp -mfloat-abi=hard -march=armv6zk -mtune=arm1176jzf-s -nostartfiles $(BIN)/$(OUTPUT).o -o $(IMG)/$(OUTPUT).elf
	arm-none-eabi-objcopy $(IMG)/$(OUTPUT).elf -O $(IMG)/$(OUTPUT).elf

clean:
	find $(BIN) -type f -exec rm {} ';'
	find $(IMG) -type f -exec rm {} ';'

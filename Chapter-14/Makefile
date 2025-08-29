# ---- Simple Makefile for Chapter-14 ----
TARGET   ?= firmware
BUILD    ?= build

# Toolchain
CROSS_COMPILE ?= arm-none-eabi-
CC      := $(CROSS_COMPILE)gcc
OBJCOPY := $(CROSS_COMPILE)objcopy
SIZE    := $(CROSS_COMPILE)size

# MCU flags (override if needed: make MCU=cortex-m4)
MCU      ?= cortex-m3
CPUFLAGS := -mcpu=$(MCU) -mthumb

# Flags
CFLAGS   := $(CPUFLAGS) -O2 -g -ffunction-sections -fdata-sections -Iinclude -std=c11
LDSCRIPT ?= linker.ld
LDFLAGS  := $(CPUFLAGS) -T $(LDSCRIPT) -Wl,--gc-sections -Wl,-Map,$(BUILD)/$(TARGET).map

# Sources (src/*.c)
SRCS := $(wildcard src/*.c)
OBJS := $(patsubst src/%.c,$(BUILD)/%.o,$(SRCS))

# Outputs
ELF := $(BUILD)/$(TARGET).elf
BIN := $(BUILD)/$(TARGET).bin
HEX := $(BUILD)/$(TARGET).hex

.PHONY: all clean size check-ld
all: check-ld $(ELF) $(BIN) $(HEX) size

check-ld:
	@if [ ! -f "$(LDSCRIPT)" ]; then \
	  echo "ERROR: Linker script not found: '$(LDSCRIPT)'"; \
	  echo "Hint: Put linker.ld in Chapter-14/ or pass LDSCRIPT=path/to/your.ld"; \
	  exit 1; \
	fi

$(BUILD)/%.o: src/%.c
	@mkdir -p $(BUILD)
	$(CC) $(CFLAGS) -c $< -o $@

$(ELF): $(OBJS) $(LDSCRIPT)
	$(CC) $(OBJS) $(LDFLAGS) -o $@

$(BIN): $(ELF)
	$(OBJCOPY) -O binary $< $@

$(HEX): $(ELF)
	$(OBJCOPY) -O ihex $< $@

size: $(ELF)
	$(SIZE) -A -d $(ELF)

clean:
	rm -rf $(BUILD)

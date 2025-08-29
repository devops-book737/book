# ---- Simple Embedded Makefile ----
# Files: put your  C files in src/, headers in include/, linker.ld in repo root.

TARGET   ?= firmware
BUILD    ?= build

# Toolchain (override if needed: make CC=...):
CROSS_COMPILE ?= arm-none-eabi-
CC      := $(CROSS_COMPILE)gcc
OBJCOPY := $(CROSS_COMPILE)objcopy
SIZE    := $(CROSS_COMPILE)size

# MCU flags (change if needed)
MCU      ?= cortex-m3
CPUFLAGS := -mcpu=$(MCU) -mthumb

# Basic flags (kept simple)
CFLAGS  := $(CPUFLAGS) -O2 -g -ffunction-sections -fdata-sections -Iinclude -std=c11
LDFLAGS := $(CPUFLAGS) -T linker.ld -Wl,--gc-sections -Wl,-Map,$(BUILD)/$(TARGET).map

# Sources (simple: only src/*.c)
SRCS := $(wildcard src/*.c)
OBJS := $(patsubst src/%.c,$(BUILD)/%.o,$(SRCS))

ELF := $(BUILD)/$(TARGET).elf
BIN := $(BUILD)/$(TARGET).bin
HEX := $(BUILD)/$(TARGET).hex

.PHONY: all clean size
all: $(ELF) $(BIN) $(HEX) size

$(BUILD)/%.o: src/%.c
	@mkdir -p $(BUILD)
	$(CC) $(CFLAGS) -c $< -o $@

$(ELF): $(OBJS) linker.ld
	$(CC) $(OBJS) $(LDFLAGS) -o $@

$(BIN): $(ELF)
	$(OBJCOPY) -O binary $< $@

$(HEX): $(ELF)
	$(OBJCOPY) -O ihex $< $@

size: $(ELF)
	$(SIZE) -A -d $(ELF)

clean:
	rm -rf $(BUILD)

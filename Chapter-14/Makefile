# ---- Chapter-14 Simple Makefile with linker fallback ----
TARGET   ?= firmware
BUILD    ?= build

# Toolchain
CROSS_COMPILE ?= arm-none-eabi-
CC      := $(CROSS_COMPILE)gcc
OBJCOPY := $(CROSS_COMPILE)objcopy
SIZE    := $(CROSS_COMPILE)size

# MCU (override if needed: make MCU=cortex-m4)
MCU      ?= cortex-m3
CPUFLAGS := -mcpu=$(MCU) -mthumb

# Flags
CFLAGS   := $(CPUFLAGS) -O2 -g -ffunction-sections -fdata-sections -Iinclude -std=c11

# Linker script (optional)
LDSCRIPT ?= linker.ld

# Auto-detect linker script presence
ifneq ($(wildcard $(LDSCRIPT)),)
  LD_SCRIPT_FLAG := -T $(LDSCRIPT)
  LD_FALLBACK    := 0
else
  LD_SCRIPT_FLAG :=
  LD_FALLBACK    := 1
endif

# Link flags (fallback adds hosted-ish specs to allow linking without custom ld script)
LDFLAGS := $(CPUFLAGS) -Wl,--gc-sections -Wl,-Map,$(BUILD)/$(TARGET).map $(LD_SCRIPT_FLAG)
ifeq ($(LD_FALLBACK),1)
  # Fallback: not device-ready; just to let CI build artifacts
  LDFLAGS += --specs=nosys.specs --specs=nano.specs -Wl,-e,main
endif

# Sources (src/*.c)
SRCS := $(wildcard src/*.c)
OBJS := $(patsubst src/%.c,$(BUILD)/%.o,$(SRCS))

# Outputs
ELF := $(BUILD)/$(TARGET).elf
BIN := $(BUILD)/$(TARGET).bin
HEX := $(BUILD)/$(TARGET).hex

.PHONY: all clean size info
all: info $(ELF) $(BIN) $(HEX) size

info:
ifeq ($(LD_FALLBACK),1)
	@echo "NOTE: '$(LDSCRIPT)' not found. Using GCC fallback link (demo build)."
else
	@echo "Using linker script: $(LDSCRIPT)"
endif

$(BUILD)/%.o: src/%.c
	@mkdir -p $(BUILD)
	$(CC) $(CFLAGS) -c $< -o $@

# If LDSCRIPT is missing, do not depend on it
ifeq ($(LD_FALLBACK),1)
$(ELF): $(OBJS)
	$(CC) $(OBJS) $(LDFLAGS) -o $@
else
$(ELF): $(OBJS) $(LDSCRIPT)
	$(CC) $(OBJS) $(LDFLAGS) -o $@
endif

$(BIN): $(ELF)
	$(OBJCOPY) -O binary $< $@

$(HEX): $(ELF)
	$(OBJCOPY) -O ihex $< $@

size: $(ELF)
	$(SIZE) -A -d $(ELF)

clean:
	rm -rf $(BUILD)

# Debug helper: print any var -> make print-VARNAME
.PHONY: print-%
print-%:
	@echo '$*=$($*)'

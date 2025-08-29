# ---- Chapter-14 Makefile (robust with fallback & dummy main) ----
TARGET   ?= firmware
BUILD    ?= build

# Toolchain
CROSS_COMPILE ?= arm-none-eabi-
CC      := $(CROSS_COMPILE)gcc
OBJCOPY := $(CROSS_COMPILE)objcopy
SIZE    := $(CROSS_COMPILE)size

# MCU (override: make MCU=cortex-m4)
MCU      ?= cortex-m3
CPUFLAGS := -mcpu=$(MCU) -mthumb

# Flags
CFLAGS   := $(CPUFLAGS) -O2 -g -ffunction-sections -fdata-sections -Iinclude -std=c11

# Optional linker script
LDSCRIPT ?= linker.ld

# Detect presence of linker script
ifneq ($(wildcard $(LDSCRIPT)),)
  LD_SCRIPT_FLAG := -T $(LDSCRIPT)
  LD_FALLBACK    := 0
else
  LD_SCRIPT_FLAG :=
  LD_FALLBACK    := 1
endif

# Sources (src/*.c)
SRCS := $(wildcard src/*.c)

# If no sources, create a tiny dummy main so CI can produce artifacts
ifeq ($(strip $(SRCS)),)
  DUMMY := 1
  SRCS := $(BUILD)/__dummy.c
endif

# Objects
OBJS := $(patsubst src/%.c,$(BUILD)/%.o,$(filter src/%.c,$(SRCS)))

# For dummy path (BUILD/__dummy.c -> BUILD/__dummy.o)
ifneq ($(filter $(BUILD)/__dummy.c,$(SRCS)),)
  OBJS += $(BUILD)/__dummy.o
endif

# Outputs
ELF := $(BUILD)/$(TARGET).elf
BIN := $(BUILD)/$(TARGET).bin
HEX := $(BUILD)/$(TARGET).hex
MAP := $(BUILD)/$(TARGET).map

# Link flags
LDFLAGS := $(CPUFLAGS) -Wl,--gc-sections -Wl,-Map,$(MAP) $(LD_SCRIPT_FLAG)
ifeq ($(LD_FALLBACK),1)
  # Fallback to allow linking without custom script (demo/test artifacts)
  LDFLAGS += --specs=nosys.specs --specs=nano.specs -Wl,-e,main
endif

.PHONY: all clean size info
all: prep info $(ELF) $(BIN) $(HEX) size

# Ensure build dir exists early
prep:
	@mkdir -p $(BUILD)

info:
ifeq ($(LD_FALLBACK),1)
	@echo "NOTE: '$(LDSCRIPT)' not found. Using GCC fallback link (demo build)."
else
	@echo "Using linker script: $(LDSCRIPT)"
endif
ifdef DUMMY
	@echo "No sources in src/. Generating a dummy main for CI artifacts."
endif

# Compile rules
$(BUILD)/%.o: src/%.c
	@mkdir -p $(BUILD)
	$(CC) $(CFLAGS) -c $< -o $@

# Dummy main (only when needed)
$(BUILD)/__dummy.c:
	@mkdir -p $(BUILD)
	@echo 'int main(void){ for(;;){} return 0; }' > $@

$(BUILD)/__dummy.o: $(BUILD)/__dummy.c
	$(CC) $(CFLAGS) -c $< -o $@

# Link (create build dir just in case)
$(ELF): $(OBJS)
	@mkdir -p $(BUILD)
	$(CC) $(OBJS) $(LDFLAGS) -o $@

$(BIN): $(ELF)
	$(OBJCOPY) -O binary $< $@

$(HEX): $(ELF)
	$(OBJCOPY) -O ihex $< $@

size: $(ELF)
	$(SIZE) -A -d $(ELF)

clean:
	rm -rf $(BUILD)

# Debug helper
.PHONY: print-%
print-%:
	@echo '$*=$($*)'

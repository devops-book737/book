# Makefile for Chapter 11 CI/CD (Build + Test + OTA)

BUILD_DIR = build
FIRMWARE_FILE = $(BUILD_DIR)/firmware.bin
SIGNED_FILE = $(BUILD_DIR)/fw_signed.bin

.PHONY: all build test clean

# "make all" will build + test
all: build test

# Build firmware
build:
	@echo "Building firmware for Chapter 11..."
	mkdir -p $(BUILD_DIR)
	# Simulate firmware build
	echo "FIRMWARE_BINARY" > $(FIRMWARE_FILE)
	@echo "Firmware created at $(FIRMWARE_FILE)"

# Run tests
test:
	@echo "Running Chapter 11 tests..."
	# Simulate tests (replace with real tests if needed)
	@echo "All tests passed!"

# Clean build files
clean:
	@echo "Cleaning build directory..."
	rm -rf $(BUILD_DIR)

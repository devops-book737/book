# Makefile for IoT Edge  Device CI/CD Pipeline (Firmware Build and Test)

BUILD_DIR = build
FIRMWARE_FILE = $(BUILD_DIR)/firmware.bin

all: firmware test

firmware:
	@echo "Building firmware..."
	mkdir -p $(BUILD_DIR)
	# Simulate build process
	touch $(FIRMWARE_FILE)
	@echo "Firmware built at $(FIRMWARE_FILE)"

test:
	@echo "Running tests..."
	# Dummy test simulation
	@echo "All tests passed!"

clean:
	@echo "Cleaning build files..."
	rm -rf $(BUILD_DIR)

.PHONY: all firmware test clean

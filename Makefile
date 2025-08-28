# Makefile for IoT Edge Device CI/CD Pipeline (Firmware Build and Test)

# Variables
BUILD_DIR = build
FIRMWARE_FILE = $(BUILD_DIR)/firmware.bin

# Default target (this will be executed if no target is specified)
all: firmware test

# Build the firmware
firmware:
	@echo "Building firmware..."
	# Create the build directory if it doesn't exist
	mkdir -p $(BUILD_DIR)
	# Example build command (adjust this to match your actual build system)
	# This assumes you have a makefile in a `firmware` folder or other build system
	# Modify the command below based on your actual firmware build process
	make -C $(PWD) all

	@echo "Firmware built at $(FIRMWARE_FILE)"

# Run tests
test:
	@echo "Running tests..."
	# Replace with your actual testing command
	# For example, running unit tests on the built firmware or any testing tool
	./run_tests.sh

# Clean up build files (optional)
clean:
	@echo "Cleaning build files..."
	rm -rf $(BUILD_DIR)

# Phony targets (ensures make doesn't treat these as files)
.PHONY: all firmware test clean

#!/bin/env bash

# Script file to set the needed environment variables.
# Use it with 'source <filename>' to set the variables in the current console.
export TOOLCHAIN_PATH="/opt/gcc-arm-none-eabi-15.2.1-1.1"
export USERPROFILE="/home/erich"
export SEGGER_PATH="/opt/SEGGER/JLink"
export SEGGER_GDB_SERVER="$SEGGER_PATH/JLinkGDBServerCLExe"
# then perform build with CMake or run VS Code with 'code . -n'


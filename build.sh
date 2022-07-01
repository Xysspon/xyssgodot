#!/bin/bash

set -e
cd `dirname $0`

OSNAME=`uname -s`

if [ $OSNAME = "Linux" ]; then
	echo "Building for Linux"

	# https://github.com/godotengine/godot/issues/44532
	mkdir -p ~/.local/share/godot/mono/GodotNuGetFallbackFolder

	#scons -c
	scons -j12 platform=linuxbsd tools=yes module_mono_enabled=yes mono_glue=no
	./bin/godot.linuxbsd.tools.64.mono --generate-mono-glue modules/mono/glue/
	scons -j12 platform=linuxbsd tools=yes module_mono_enabled=yes mono_glue=yes
elif [ $OSNAME = "Darwin" ]; then
	echo "Building for MacOS..."
else
	echo "Unknown OS: $OSNAME"
	exit 1
fi

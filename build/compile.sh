#!/bin/bash

# load modules
modules=$(ls -d -- "$MODULE_DIRNAME/*" 2> /dev/null)
if [ ! -z "$modules"]; then
  module_requires=""
  while read -r module; do
    echo "$module"
    module_requires="$module_requires \n\
  --compiler_flags=\"--js $module/$MODULE_INDEX\""
  done <<< "$modules"
fi

compile_command="\"$CLOSURE_BUILDER\" \n\
  --root=\"$PUBLIC_DIRNAME/lib\" \n\
  --root=\"$PUBLIC_DIRNAME/app\" \n\
  --namespace=\"app\" \n\
  --output_mode=\"compiled\" \n\
  --compiler_jar=\"$CLOSURE_COMPILER\" \n\
  --compiler_flags=\"--compilation_level=ADVANCED_OPTIMIZATIONS\" \n\
  --compiler_flags=\"--warning_level=VERBOSE\" \n\
  --compiler_flags=\"--language_in=ECMASCRIPT5_STRICT\" \n\
  --compiler_flags=\"--create_source_map=$SOURCE_MAP_FILENAME\" \n\
  --compiler_flags=\"--js=$CLOSURE_LIBRARY_DIRNAME/closure/goog/deps.js\" \n\
  $module_requires \n\
  --compiler_flags=\"--output_wrapper=(function(){%output%}).call(this); \n\
    //@ sourceMappingURL=$SOURCE_MAP_FILENAME\" \n\
"

$compile_command


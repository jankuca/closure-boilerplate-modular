#!/bin/bash

export PUBLIC_DIRNAME="./public"
export BUILD_TOOL_DIRNAME="./build"
export BUILD_RESULT_DIRNAME="$PUBLIC_DIRNAME/build"
export LIB_DIRNAME="$PUBLIC_DIRNAME/lib"

export CLOSURE_LIBRARY_DIRNAME="$LIB_DIRNAME/closure-library"
export CLOSURE_COMPILER_DIRNAME="$BUILD_TOOL_DIRNAME/closure-compiler"

export CLOSURE_BUILDER="$CLOSURE_LIBRARY_DIRNAME/closure/bin/build/closurebuilder.py"
export CLOSURE_DEPSWRITER="$CLOSURE_LIBRARY_DIRNAME/closure/bin/build/depswriter.py"
export CLOSURE_COMPILER="$CLOSURE_COMPILER_DIRNAME/compiler.jar"

export JS_BUILD_RESULT_FILENAME="$BUILD_RESULT_DIRNAME/app.min.js"
export JS_DEPENDENCY_FILENAME="$BUILD_RESULT_DIRNAME/deps.js"
export JS_MODULE_LOADER_FILENAME="$BUILD_RESULT_DIRNAME/modules.js"
export SOURCE_MAP_FILENAME="$BUILD_RESULT_DIRNAME/source-map.json"

export MODULE_DIR_BASENAME="modules"
export MODULE_DIRNAME="$PUBLIC_DIRNAME/$MODULE_DIR_BASENAME"
export MODULE_INDEX="index.js"


ex() {
  "$1" && {
    echo -e "  \033[0;32mOK\033[0;0m" >&2
  } || {
    echo -e "  \033[0;31mError\033[0;0m" >&2
  }
}


echo ""
echo -e "  \033[2;37mBuilding...\033[0m"
echo ""

echo -e "- \033[4;36mDependencies:\033[0m\033[2;37m"
ex "$BUILD_TOOL_DIRNAME/deps.sh" > "$JS_DEPENDENCY_FILENAME"
echo -e "\033[0;0m"

echo -e "- \033[4;36mModule Loader:\033[0m\033[2;37m"
ex "$BUILD_TOOL_DIRNAME/modules.sh" > "$JS_MODULE_LOADER_FILENAME"
echo -e "\033[0;0m"

echo -e "- \033[4;36mCompilation:\033[0m\033[2;37m"
ex "$BUILD_TOOL_DIRNAME/compile.sh" > "$JS_BUILD_RESULT_FILENAME"
echo -e "\033[0;0m"


echo -e "  \033[2;37mDone\033[0;0m"

#!/bin/bash

# load modules
modules=$(ls -d -- "$MODULE_DIRNAME")

# output a header
echo "(function () {"
echo "  var addModule = function (key) {"
echo "    var src = './$MODULE_DIR_BASENAME/' + key + '/$MODULE_INDEX';"
echo "    document.write('<'+'script src="' + src + '"><'+'/script>');"
echo "  };"
echo "  "

if [ ! -z "$modules" ]; then
  while read -r module; do
    echo "  addModule('$module');"
  done <<< "$modules"
fi

echo "}());"

#bslib='/usr/local/google/home/rossberg/ocaml/bucklescript/lib/js'

link () {
echo "// DO NOT EDIT. Generated from WebAssembly spec interpreter"
echo "
let WebAssemblyText = (function() {
  let _registry = {__proto__: null};
  function normalize(file) {
    return file.split('/').reverse()[0].split('.')[0];
  }
  function require(file) {
    let name = normalize(file);
    if (!(name in _registry)) {
      throw new Error('missing module: ' + name)
    } else if (typeof _registry[name] === 'function') {
"
if (($LOG == 1))
then
  echo 1>&2 Logging on
  echo "
    console.log(name);
"
fi
echo "
      let f = _registry[name];
      _registry[name] = function() { throw new Error('cyclic module: ' + name) };
      _registry[name] = f();
    }
    return _registry[name];
  }
"

#for file in `ls $bslib/*.js lib/js/gen/*.js | grep -v Labels | grep -v node_ | grep -v js_ | grep -v bs_`
for file in $*
do
  echo 1>&2 Including $file
  name=`basename $file | sed s/.js//g`
  echo "
  _registry['$name'] = function() {
    let exports = {};
//////// start of $name.js ////////"
  cat $file
  echo "//////// end of $name.js ////////
    return exports;
  };
"
done

echo "
  function binary(bytes) {
    let buffer = new ArrayBuffer(bytes.length);
    let view = new Uint8Array(buffer);
    for (let i = 0; i < bytes.length; ++i) {
      view[i] = bytes.charCodeAt(i);
    }
    return buffer;
  }
  let Wasm = require('wasm');
  return {encode(s) { return binary(Wasm.encode(s)) }};
})();

"
}

echo 1>&2 ==== Compiling ====
BSPATH=`which bsb`
BPATH=`dirname $BSPATH`/../lib/js
echo 1>&2 BSPATH = $BSPATH
bsb
cp `dirname $BSPATH`/../lib/js/*.js lib/js/src

echo 1>&2 ==== Linking full version ====
LOG=1
link lib/js/src/*.js >temp.js

echo 1>&2 ==== Running for dependencies ====
node temp.js >temp.log

echo 1>&2 ==== Linking stripped version ====
used=''
for file in `ls lib/js/src/*.js`
do
  if grep -q `basename $file | sed s/.js//g` temp.log
  then
    used="$used $file"
  fi
done
LOG=0
link $used >$1
rm temp.*


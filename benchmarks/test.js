var testBuffer = read('test.wasm','binary');
var m = new WebAssembly.Module(testBuffer);
function testImport()
{
	console.log("Import called");
}
var i = new WebAssembly.Instance(m, {i:{import:testImport}});
i.exports.test(0x7fffffff);

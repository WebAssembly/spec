const warmup = 3;
const iters = 5;

function testImport()
{
}
function readModule(path)
{
	const buf = read(path,'binary');
	const m = new WebAssembly.Module(buf);
	const i = new WebAssembly.Instance(m, {i:{import:testImport}});
	return i;
}

const modules = [
	{path: 'test.wasm', desc: "vanilla code"},
	{path: 'test_hint.wasm', desc: "branch hinting proposal"},
];
function doBench(m)
{
	const start = Date.now();
	m.exports.test(0x7fffffff);
	const end = Date.now();
	return end - start;
}

function benchmark(m)
{
	for (let i = 0; i < warmup; i++)
		doBench(m);

	const results = [];

	for (let i = 0; i < iters; i++)
		results.push(doBench(m));

	return results;
}

function stats(results)
{
	const mean = results.reduce((acc, i) => acc+i, 0)/results.length;
	const stddev = Math.sqrt(results.reduce((acc,i) => acc+(i-mean)*(i-mean), 0)/results.length);

	return { mean, stddev };

}

for (let m of modules) {
	console.log(`Running '${m.desc}'...`);
	const i = readModule(m.path);
	const res = benchmark(i);
	const { mean, stddev} = stats(res);

	console.log("mean=",mean,"; stddev=",stddev);
	console.log("--------------------------");
}


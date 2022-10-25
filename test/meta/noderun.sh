if [ $# -ne 2 ]; then
    echo "Bad args"
    exit 1
fi

rm -f nodeprog.js
cat <<EOF >> nodeprog.js
const WITH_SHARED_MEMORY=$1;
function print(x) {
    console.log(x);
}
EOF
cat common.js >> nodeprog.js
cat $2 >> nodeprog.js
node nodeprog.js
rm nodeprog.js

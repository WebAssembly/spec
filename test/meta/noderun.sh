if [ $# -ne 3 ]; then
    echo "Bad args"
    exit 1
fi

rm -f nodeprog.js
cat <<EOF >> nodeprog.js
const WITH_SHARED_MEMORY=$1;
const INDEX_TYPE='$2';
function print(x) {
    console.log(x);
}
EOF
cat common.js >> nodeprog.js
cat $3 >> nodeprog.js
node nodeprog.js
rm nodeprog.js

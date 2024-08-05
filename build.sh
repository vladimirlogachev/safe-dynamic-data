elm make --optimize --output="bundle.temp.js" src/Schema1.elm

npx uglify-js@3.7.6 "./bundle.temp.js" --compress 'pure_funcs="F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9",pure_getters,keep_fargs=false,unsafe_comps,unsafe' | npx uglify-js@3.7.6 --mangle --output="./dist/bundle.js"

echo "Size: bundle.temp.js $(du -sk bundle.temp.js | cut -f1) kB"
echo "Size: dist/bundle.js $(du -sk dist/bundle.js | cut -f1) kB"

rm bundle.temp.js

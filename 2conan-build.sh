jf c add $SERVER_ID --url=$URL --access-token=$ACCESS_TOKEN --interactive=false
jf rt ping

apt-get install gcc g++ cmake  
    
mkdir build
conan profile detect --force
conan install . --output-folder=build --build=missing

cd build
cmake .. -DCMAKE_TOOLCHAIN_FILE=conan_toolchain.cmake -DCMAKE_BUILD_TYPE=Release
cmake --build .

echo 1.0.${{github.run_number}}
jf rt upload compressor samk-generic-local/compressor/1.0.${{github.run_number}} --build-name=compressor-build --build-number=1.0.${{github.run_number}}
jf rt build-publish samk-generic-local/compressor 1.0.${{github.run_number}}
jf rt build-scan samk-generic-local/compressor 1.0.${{github.run_number}}

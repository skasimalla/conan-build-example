echo "Starting build"
echo $URL
jf c add $SERVER_ID --url=$URL --access-token=$ACCESS_TOKEN --interactive=false
jf rt ping

apt-get install gcc g++ cmake  
    
mkdir build
conan profile detect --force
conan install . --output-folder=build --build=missing

cd build
cmake .. -DCMAKE_TOOLCHAIN_FILE=conan_toolchain.cmake -DCMAKE_BUILD_TYPE=Release
cmake --build .

BUILD_NUMBER=1.0.51

echo $BUILD_NUMBER


jf rt upload compressor samk-generic-local/compressor/1.0.${{BUILD_NUMBER}} --build-name=compressor-build --build-number=1.0.${{BUILD_NUMBER}}
jf rt build-publish samk-generic-local/compressor 1.0.${{BUILD_NUMBER}}
jf rt build-scan samk-generic-local/compressor 1.0.${{BUILD_NUMBER}}

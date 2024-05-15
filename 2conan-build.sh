echo "Starting build"

apt-get install gcc g++ cmake  
    
rm -rf build
mkdir -p build


cp ../src/* . 
cp ../conanfile.txt .
cp ../CMakeLists.txt .
ls -lrt


conan profile detect --force
conan install . --output-folder=build --build=missing

cd build
cmake .. -DCMAKE_TOOLCHAIN_FILE=conan_toolchain.cmake -DCMAKE_BUILD_TYPE=Release
cmake --build .

#Uploading to RT

echo $URL
jf c add $SERVER_ID --url=$URL --access-token=$ACCESS_TOKEN --interactive=false
jf rt ping

echo $BUILD_NUMBER

export JFROG_CLI_BUILD_URL=http://mill.jfrog.info:13132/
export JFROG_CLI_BUILD_NAME=compressor-tc
export JFROG_CLI_BUILD_NUMBER=$BUILD_NUMBER

pwd


jf rt build-add-git samk-generic-local 1.0.${BUILD_NUMBER}
jf rt build-collect-env samk-generic-local 1.0.${BUILD_NUMBER}

jf rt upload compressor samk-generic-local/compressor-tc/1.0.${BUILD_NUMBER} --build-name=compressor-build --build-number=1.0.${BUILD_NUMBER}
jf rt build-publish samk-generic-local/compressor-tc 1.0.${BUILD_NUMBER}
jf rt build-scan samk-generic-local/compressor-tc 1.0.${BUILD_NUMBER}

echo "Starting build"

#THis shoulld go in the agent heating script
REM $env:Path += ';C:\Program Files\Conan\conan'
REM $env:Path += ';C:\Program Files\CMake\bin'


SET PATH=%PATH%;C:\Program Files\Conan\conan
SET PATH=%PATH%;C:\Program Files\CMake\bin


#apt-get install gcc g++ cmake  
    
rm -rf build
mkdir -p build


conan profile detect --force
conan install . --output-folder=build --build=missing

cd build

cp ../src/* . 
cp ../conanfile.txt .
cp ../CMakeLists.txt .
ls -lrt

cmake .. -DCMAKE_TOOLCHAIN_FILE=conan_toolchain.cmake -DCMAKE_BUILD_TYPE=Release
cmake --build .

#Uploading to RT

echo $URL
jf c add $SERVER_ID --url=$URL --access-token=$ACCESS_TOKEN --interactive=false
jf rt ping

echo $BUILD_NUMBER

REM export JFROG_CLI_BUILD_URL=http://mill.jfrog.info:13132/
REM export JFROG_CLI_BUILD_NAME=compressor-tc
REM export JFROG_CLI_BUILD_NUMBER=$BUILD_NUMBER

pwd

zip -r compressor.zip . 
jf rt build-add-git samk-generic-local 1.0.${BUILD_NUMBER}
jf rt build-collect-env samk-generic-local 1.0.${BUILD_NUMBER}
jf rt bad compressor-tc 1.0.${BUILD_NUMBER} ./

jf rt upload compressor.zip samk-generic-local/compressor-tc/compressor-1.0.${BUILD_NUMBER}.zip --build-name=compressor-tc --build-number=1.0.${BUILD_NUMBER}
jf rt build-publish samk-generic-local/compressor-tc 1.0.${BUILD_NUMBER}
jf rt build-scan samk-generic-local/compressor-tc 1.0.${BUILD_NUMBER}

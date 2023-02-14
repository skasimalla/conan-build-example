rm -rf build
mkdir -p build
cd build
#conan install .. -s build_type=Release --build=missing
#-r {{repo_name}} 

cp ../src/* . 
cp ../conanfile.txt .
cp ../CMakeLists.txt .
ls -lrt

conan install . -s build_type=Debug --build=missing
cmake ./CMakeLists.txt -G "Visual Studio 16 2019" -A "x64"
cmake .
cmake --build . --config Release
#mkdir -p bin
#cd bin
#./Example
#echo "Success"
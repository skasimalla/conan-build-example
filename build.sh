mkdir -p build
cd build
conan install .. -s build_type=Release --build=missing
#-r {{repo_name}}  
conan install .. -s build_type=Debug --build=missing
cmake ../CMakeLists.txt -G "Visual Studio 16 2019" -A "x64"
cmake --build . --config Release
cd bin
./Example
echo "Success"
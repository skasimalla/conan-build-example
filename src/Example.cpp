#include <iostream>
#include <random>
#include <ctime>

int main() {
    
    std::string haikus[3] = {
        "Conan, frog of might,\nLeaps across the moonlit night,\nSword gleams in the fight.",
        "In the swamp's deep heart,\nConan stands, set apart,\nBravery his art.",
        "Frog warrior leaps,\nEnemy lines, he sweeps,\nHis legend, it creeps."
    };


    std::srand(static_cast<unsigned int>(std::time(nullptr)));

    
    int index = std::rand() % 3;

  
    std::cout << haikus[index] << std::endl;

    return 0;
}

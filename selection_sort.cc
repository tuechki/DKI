#include <iostream>

using namespace std;

int main()
{
    int array[5] = {32,45,10,7,18};
    
    for(int counter = 0, sorted_array_counter = 0; counter < 5; counter++){
        
        for(int index = counter + 1; index < 5; index++){
            if(array[counter] > array[index]){
                int swap = array[counter];
                array[counter] = array[index];
                array[index] = swap;
            }
        }
    }
    
    for(int counter = 0; counter < 5; counter++){
        cout << array[counter] << "\t";
    }

    return 0;
}

#include<iostream>

using namespace std;

int main(){
    
    int array[5] = {10,9,8,7,6};
    
    for(int index = 0; index < 4; index++){
    
        for(int counter = 0; counter < 4; counter++){
            
            if(array[counter] > array[counter + 1]){
                int swap = array[counter];
                array[counter] = array[counter + 1];
                array[counter + 1] = swap;
            }
            
        }
    }
    
    for(int counter = 0; counter < 5; counter++){
        cout << array[counter] << "\t";
    }
    
    return 0;
}

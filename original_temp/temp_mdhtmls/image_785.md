Here's a C++ program that reads a text file line by line and counts the number of occurrences of a specific word in the file:
```cpp
#include <iostream>
#include <fstream>
#include <string>
using namespace std;

int countWord(string word, string file) {
    int count = 0;
    ifstream input(file);
    string line;
    while (getline(input, line)) {
        size_t pos = 0;
        while ((pos = line.find(word, pos)) != string::npos) {
            count++;
            pos += word.length();
        }
    }
    return count;
}

int main() {
    string word, file;
    cout << "Enter the word to search: ";
    cin >> word;
    cout << "Enter the file name: ";
    cin >> file;
    int count = countWord(word, file);
    cout << "The word '" << word << "' appears " << count << " times in the file." << endl;
    return 0;
}
```
This program prompts the user to enter a word and a file name, then reads the file line by line and counts the number of occurrences of the specified word. The `countWord` function takes the word and file name as arguments and returns the count. The main function uses `cin` to get the input from the user, calls the `countWord` function, and prints the result.


#include <iostream>
#include <string>

std::string decodeShiftCipher(const std::string& cipherText, int shift) {
    std::string decodedText = "";

    for (char ch : cipherText) {
        if (isalpha(ch)) {
            char base = isupper(ch) ? 'A' : 'a';
            decodedText += (ch - base - shift + 26) % 26 + base;
        } else {
            decodedText += ch;
        }
    }

    return decodedText;
}

int main() {
    std::string cipherText;
    int shift;

    // Input the cipher text and the shift value
    std::cout << "Enter the cipher text: ";
    std::getline(std::cin, cipherText);

    std::cout << "Enter the shift value: ";
    std::cin >> shift;

    // Decode the cipher text
    std::string decodedText = decodeShiftCipher(cipherText, shift);

    // Output the decoded text
    std::cout << "Decoded text: " << decodedText << std::endl;

    return 0;
}

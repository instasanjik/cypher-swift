//
//  Cypher.swift
//  cypher
//
//  Created by Sanzhar Koshkarbayev on 05.12.2022.
//

import Foundation

class Cypher: NSObject {
    override init() {}
    
    func caesar(value: String, shift: Int) -> String {
        var result = [Character]() // creating an empty array for filleng the result sting using caesar method
        
        for u in value.utf8 { // loop which will rncrypt5 every letter in the given word
            let s = Int(u) + shift // calculate the letter number in the ASCII table
            
            if s > 97 + 25 { // if the resulting index is outside the limits of the ASCII table with letters (greater than last letter element)
                result.append(Character(UnicodeScalar(s - 26)!))
            } else if s < 97 { // if the resulting index is outside the limits of the ASCII table with letters (smaller than last letter element)
                result.append(Character(UnicodeScalar(s + 26)!))
            } else { // resulting index in the range of letter radius
                result.append(Character(UnicodeScalar(s)!))
            }
        }
        return String(result) // returning an array converted to string
    }
    
    func trisemus(keyword: String, wordToEncrypt word: String, enablePrints: Bool = false) -> (String, [[String]]) {
        if enablePrints { // test prints
            print("-------trisemus cypher--------")
            print("keyword: \(keyword.lowercased())")
            print("word to encrypt: \(word.lowercased())")
        }
        let word = word.lowercased() // lowercase given word to encrypt
        
        let letters = Array(keyword.lowercased()) // lowercase given keyword and convert to the Array
        
        var alphabet = "A B C D E F G H IJ K L M N O P Q R S T U V W X Y Z".lowercased().components(separatedBy: " ") // constant english alphabet for encryption
        
        for (index, letter) in letters.enumerated() { // loop for inserting keyword to an alphabet array
            alphabet.insert(letter.description, at: index)
        }
        
        alphabet = alphabet.removeDuplicates() // removing duplicates from the alphabet array
        
        enablePrints ? print("\nFinal table: ") : () // test prints
        
        var table = [[String]]() // createing table (two0dimentional array) for displaying to user
        for startIndexInLine in 0...4 { // loop for filling table array
            let line = Array(alphabet[startIndexInLine*5..<startIndexInLine*5+5]) // generating line for the table
            table.append(line) // appinding to the table
            for letter in line { // test prings
                enablePrints ? print(letter, terminator: "\t") : () // test prints
            }
            enablePrints ? print("") : () // test prints
        }
        
        var encryptedWord: String = "" // creating an empty string for encrypted word
        for wordLetter in Array(word) { // loop which will encrypt all letters from the given word
            for (index, alphabetLetter) in alphabet.enumerated() { // loop which will search given letter in the alphabet array
                if alphabetLetter == wordLetter.description || ((wordLetter.description == "i" || wordLetter.description == "j") && alphabetLetter == "ij") { // check if given letter is equals to the alphabet letter OR given letter is "I" OR given letter is "J"
                    if index+5 < alphabet.count { // check if out generated index in range of our table
                        encryptedWord += alphabet[index+5] // appending letter to the created string for encrypted word
                    } else { // ckeck if out generated index is not in range of our table
                        encryptedWord += alphabet[index-20] // appending letter to the created string for encrypted word with index -20
                    }
                    break // break our alphabet searcher loop if we found the given letter
                }
            }
        }
        enablePrints ? print("\nresult: \(encryptedWord)\n") : () // test prints
        return (encryptedWord, table) // returning word with table for displaying
    }
}

extension Array where Element: Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()
        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }
        return result
    }
}

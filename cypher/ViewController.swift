//
//  ViewController.swift
//  cypher
//
//  Created by Sanzhar Koshkarbayev on 05.12.2022.
//

import Cocoa

enum CypherType {
    case caesar
    case trisemus
}

class ViewController: NSViewController {

    let cypher = Cypher()
    
    var mode: CypherType = .trisemus {
        didSet {
            guard oldValue != mode else { return }
            switch mode {
            case .caesar:
                keywordLabel.stringValue = "Shift"
                keywordTextField.placeholderString = "3"
            case .trisemus:
                keywordLabel.stringValue = "Keyword"
                keywordTextField.placeholderString = "Mouse"
            }
        }
    }
    
    @IBOutlet weak var wordToEncryptTextField: NSTextField!
    @IBOutlet weak var keywordLabel: NSTextField!
    @IBOutlet weak var keywordTextField: NSTextField!
    @IBOutlet weak var resultLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print("computer-science - \(cypher.caesar(value: "you-bro", shift: 3))")
//        print("microprocessor - \(cypher.caesar(value: "microprocessor", shift: 23))")
//        print("joufsofu - \(cypher.caesar(value: "joufsofu", shift: -1))")


        _ = cypher.trisemus(keyword: "mouse", wordToEncrypt: "Hardwarez", enablePrints: true)
    }

    @IBAction func goTapped(_ sender: NSButton) {
        switch mode {
        case .trisemus:
            var stringToDisplay: String = ""
            var keyword: String = keywordTextField.stringValue
            var wordToEncrypt = wordToEncryptTextField.stringValue
            if keywordTextField.stringValue == "" {
                keyword = "Mouse"
            }
            if wordToEncryptTextField.stringValue == "" {
                wordToEncrypt = "Supervisor"
            }
            let data = cypher.trisemus(keyword: keyword, wordToEncrypt: wordToEncrypt, enablePrints: true)
            stringToDisplay += "Final Table: \n"
            
            for line in data.1 {
                for letter in line {
                    stringToDisplay += "\(letter) \t"
                }
                stringToDisplay += "\n"
            }
            print(stringToDisplay)
            
            stringToDisplay += "\nResult: \(data.0)"
            
            resultLabel.stringValue = stringToDisplay
        case .caesar:
            resultLabel.stringValue = "result: \(cypher.caesar(value: wordToEncryptTextField.stringValue, shift: Int(keywordTextField.stringValue) ?? 3))"
        }
    }
    
    @IBAction func valueChanged(_ sender: NSComboBox) {
        resultLabel.stringValue = ""
        keywordTextField.stringValue = ""
        switch sender.stringValue {
        case "Caesar":
            mode = .caesar
        case "Trisemus":
            mode = .trisemus
        default:
            print("Опа, случился баг \(sender.stringValue)")
        }
    }
    
    
    
    override var representedObject: Any? {
        didSet {
            
        }
    }
}

//
//  EmojiDetailViewController.swift
//  Emoji Dictionary
//
//  Created by Denis Bystruev on 11/04/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class EmojiDetailViewController: UIViewController {
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var symbolField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var usageField: UITextField!
    
    var emoji: Emoji?
    var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editUIEmoji()
        updateUI()
        
        title = emoji == nil ? "add" : "edit"
        
    }
    
    func areFieldsReady() -> Bool {
        return !symbolField.isEmpty && !nameField.isEmpty && !descriptionField.isEmpty && !usageField.isEmpty && symbolField.text!.count < 2
    }
    
    func editUIEmoji(){
        guard let emoji = emoji else {return}
        symbolField.text = emoji.symbol
        nameField.text = emoji.name
        descriptionField.text = emoji.description
        usageField.text = emoji.usage
        
    }
    
    func saveEmoji() {
        let emoji = Emoji()
        emoji.symbol = symbolField.text ?? ""
        emoji.name = nameField.text ?? ""
        emoji.description = descriptionField.text ?? ""
        emoji.usage = usageField.text ?? ""
        self.emoji = emoji
    }
    
    func updateUI() {
        saveButton.isEnabled = areFieldsReady()
    }
    
    @IBAction func textChanged() {
        updateUI()
    }
}

// MARK: - Navigation
extension EmojiDetailViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        saveEmoji()
    }
}

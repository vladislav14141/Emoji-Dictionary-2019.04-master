//
//  EmojiListViewController.swift
//  Emoji Dictionary
//
//  Created by Denis Bystruev on 11/04/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class EmojiListViewController: UITableViewController {
    
    let cellID = "EmojiCell"
    let configurator = TableViewCellConfigurator()
    var emojis = Emojis.loadSample()
    
    override func viewDidLoad() {
        navigationItem.title = emojis.title
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojis.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let emoji = emojis[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! EmojiCell
        
        configurator.configure(cell, with: emoji)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "Удалить") { (action, indexPath) in
            self.emojis.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        delete.backgroundColor = #colorLiteral(red: 0.4439244924, green: 0.004352200906, blue: 0.004352200906, alpha: 1)
        return [delete]
    }

}

// MARK: - Navigation
extension EmojiListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "editSegue" else {return}
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        guard let dvc = segue.destination as? EmojiDetailViewController else {return}
        
        dvc.indexPath = indexPath
        dvc.emoji = emojis[indexPath.row]
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue) {        
        guard segue.identifier == "SaveSegue" else { return }
        guard let controller = segue.source as? EmojiDetailViewController else { return }
        guard let emoji = controller.emoji else {return}
        
        if controller.indexPath != nil, let indexPath = controller.indexPath{
            emojis[indexPath.row] = emoji
            tableView.reloadRows(at: [indexPath], with: .left)
            
        } else {
            let indexPath = IndexPath(row: emojis.count, section: 0)
            emojis.append(emoji)
            tableView.insertRows(at: [indexPath], with: .automatic)
            
        }
    }
}

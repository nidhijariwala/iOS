//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Nidhi Jariwala on 2021-06-15.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let cellReuseIdentifier = "cell"
    private var models = [ToDoListItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "CoreData To Do List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        // Do any additional setup after loading the view.
        getAllItems()
    }
    
    @objc private func didTapAdd() {
        let alert = UIAlertController(title: "New Item", message: "Enter new item", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { [weak self]_ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
                return
            }
            self?.createItem(name: text)
        }))
        present(alert, animated: true)
    }
    
    // number of rows in table view
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return models.count
        }
        
        // create a cell for each table view row
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let model = models[indexPath.row]
            // create a new cell if needed or reuse an old one
            let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier, for: indexPath) 
            
            // set the text from the data model
            cell.textLabel?.text = model.name
            
        
            
            return cell
        }
        
        // method to run when table view cell is tapped
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            let item = models[indexPath.row]
            let sheet = UIAlertController(title: "Edit ", message: nil, preferredStyle: .actionSheet)
            
            sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
                let alert = UIAlertController(title: "Edit Item", message: "Edit your item", preferredStyle: .alert)
                alert.addTextField(configurationHandler: nil)
                alert.textFields?.first?.text = item.name
                alert.addAction(UIAlertAction(title: "Save", style: .cancel, handler: { [weak self]_ in
                    guard let field = alert.textFields?.first, let newName = field.text, !newName.isEmpty else {
                        return
                    }
                    self?.updateItem(item: item, newName: newName)
                }))
                self.present(alert, animated: true)
            }))
            sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                self.deleteItem(item: item)
            }))
            present(sheet, animated: true)
        }
        

    // Core Data
    func getAllItems() {
        
        do {
            models = try context.fetch(ToDoListItem.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        catch {
            //error
        }
    }
    
    func createItem(name: String) {
        let newItem = ToDoListItem(context: context)
        newItem.name = name
        newItem.createdAt = Date()
        
        do {
            try context.save()
            getAllItems()
        }
        catch {
            
        }
    }

    func deleteItem(item: ToDoListItem) {
        context.delete(item)
        do {
            try context.save()
            getAllItems()
        }
        catch {
            
        }
    }
    
    func updateItem(item: ToDoListItem, newName: String) {
        item.name = newName
        do {
            try context.save()
            getAllItems()
        }
        catch {
            
        }
    }
}


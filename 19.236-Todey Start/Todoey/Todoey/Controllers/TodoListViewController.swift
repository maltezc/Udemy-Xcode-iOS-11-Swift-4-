//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Chris Maltez on 10/26/18.
//  Copyright © 2018 Christopher Maltez. All rights reserved.
//
//Xcode Intellisense V
//https://stackoverflow.com/questions/6662395/xcode-intellisense-meaning-of-letters-in-colored-boxes-like-f-t-c-m-p-c-k-etc

// for debugger, scroll to top of stacktrace to find reasons



import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {

    var todoItems = Results<Item>?
    let realm = try! Realm()

    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }



    // dont UserDefaults for anything other than UserDefault settings like volume or similar.

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

    }

    //MARK - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)

        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            // Ternary Operator ==>
            // value = condition ? valueIfTrue : valueIfFalse
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added"
        }

        return cell
    }

    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
//                    realm.delete(item)
                    item.done = !item.done
                }
            } catch {
                print("Error saving done status, \(error)")
            }
        }

        tableView.reloadData()

        tableView.deselectRow(at: indexPath, animated: true)

    }
    //MARK - Add New Items
     
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {

            var textField = UITextField()

            let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
                //What will happen once the user clicks the Add Item Button on our UIAlert

             if let currentCategory = self.selectedCategory {
                 do {
                     try realm.write {
                         let newItem = Item()
                         newItem.title = textField.text!
                         newItem.dateCreated = Date()
                         currentCategory.items.append(newItem)
                     }
                 } catch {
                     print("Error saving new items, \(error)")
                 }
             }
            tableView.reloadData()
            }
            
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "Create new item"
                textField = alertTextField
                
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }


         //Mark - Model Manipulation Methods


        func loadItems() {
            todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
            tableView.reloadData()
        }

}

// MARK: - Search Bar Methods
// see realm database docs. ==> academy.realm.io/posts/nspredicate-cheatsheet/
extension TodoListViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)

        tableView.reloadData()

    }

    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()

            DispatchQueue.main.async{
                searchBar.resignFirstResponder()
            }

        }
    }
}












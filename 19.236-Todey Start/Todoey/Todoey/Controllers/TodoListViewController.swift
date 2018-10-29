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
import CoreData

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    // dont UserDefaults for anything other than UserDefault settings like volume or similar.

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

        loadItems()

    }

    //MARK - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)

        let item = itemArray[indexPath.row]

        cell.textLabel?.text = item.title


        // Ternary Operator ==>
        // value = condition ? valueIfTrue : valueIfFalse

        cell.accessoryType = item.done ? .checkmark : .none



        return cell
    }

    //MAR - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])


//        context.delete(itemArray[indexPath.row]) //this needs to come first ****
//        itemArray.remove(at: indexPath.row) // This needs to come second!!!

//        itemArray[indexPath.row].done = !itemArray[indexPath.row].done

//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }

        saveitems()


        tableView.deselectRow(at: indexPath, animated: true)

    }
    //MARK - Add New Items
     
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {

            var textField = UITextField()

            let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
                //What will happen once the user clicks the Add Item Button on our UIAlert

                let newItem = Item(context: self.context)
                newItem.title = textField.text!
                newItem.done = false
                self.itemArray.append(newItem)

                self.saveitems()

            }
            
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "Create new item"
                textField = alertTextField
                
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }


         //Mark - Model Manipulation Methods
        func saveitems() {
            let encoder = PropertyListEncoder()

            do {
               try context.save()
            } catch {
                print("Error saving context \(error)")
            }

            self.tableView.reloadData()
        }

        func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
            do {
                itemArray = try context.fetch(request)
            } catch {
                print("Error fetching data from context \(context)")
            }
        }

}

// MARK: - Search Bar Methods
extension TodoListViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//        look at academy.realm.io/posts/nspredicate-cheatsheet/
//        also check out nshipster.com/nspredicate

        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]

        loadItems(with: request)

    }

}












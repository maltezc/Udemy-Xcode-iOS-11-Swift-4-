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

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    // dont UserDefaults for anything other than UserDefault settings like volume or similar.

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.



        print(dataFilePath)


        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)

        let newItem2 = Item()
        newItem2.title = "Find Mike2"
        itemArray.append(newItem2)

        let newItem3 = Item()
        newItem3.title = "Find Mike3"
        itemArray.append(newItem3)




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


        itemArray[indexPath.row].done = !itemArray[indexPath.row].done

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
                let newItem = Item()
                newItem.title = textField.text!

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
                let data = try encoder.encode(itemArray)
                try data.write(to: dataFilePath!)
            } catch {
                print("Error encoding item array, \(error)")
            }

            self.tableView.reloadData()
        }

        func loadItems() {
            if let data = try? Data(contentsOf: dataFilePath!) {
                // ^optional binding
                let decoder = PropertyListDecoder()
                do {
                    itemArray = decoder.decode([Item].self, from: data)
                } catch {
                    print("Error decoding item array,  \(error)")

                }

            }
        }



}












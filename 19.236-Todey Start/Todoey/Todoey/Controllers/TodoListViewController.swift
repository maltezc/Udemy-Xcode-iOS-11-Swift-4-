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
import ChameleonFramework

class TodoListViewController: SwipeTableViewController {

    var todoItems = Results<Item>?
    let realm = try! Realm()

    @IBOutlet weak var searchBar: UISearchBar!

    
    
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }



    // dont UserDefaults for anything other than UserDefault settings like volume or similar.

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        tableView.separatorStyle = .none
    }

//    view will appear is "loaded" right before view did load
    override func viewWillAppear(_ animated: Bool) {

        title = selectedCategory?.name

        guard let colorHex = selectedCategory?.color else { fatalError() }

        updateNavBar(withHexCode: "1D9BF6")
    }

    override func viewWillDisappear(_ animated: Bool) {

        updateNavBar(withHexCode: "1D9BF6")
    }


    //MARK: - Nav Bar Setup Methods
    func updateNavBar(withHexCode colorHexCode: String) {
        guard let navBar = navigationController?.navigationBar else {fatalError("Navigation Controller does not exist")}

        //        let navBarColor = FlatWhite()  <--testing line

        guard let navBarColor = UIColor(hexString: colorHexCode) else { fatalError() }

        navBar.barTintColor = navBarColor

        navBar.tintColor = ContrastColorOf(navBarColor, returnFlat: true)

        navBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : ContrastColorOf(navBarColor, returnFlat: true)]

        searchBar.barTintColor = navBarColor
    }

    //MARK - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        let cell = super.tableView(tableView, cellForRowAt: indexPath)

        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title

            if let color = UIColor(hexString: selectedCategory!.color)?.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(todoItems!.count)) {

                cell.backgroundColor = color
                cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
            }

//            print("version 1: \(CGFloat(indexPath.row / todoItems!.count))")


//            print("version 2: \(CGFloat(indexPath.row) / CGFloat(todoItems!.count))")

                //currently on row #5
                //theres a total of 10 items in todoItems




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

        override func updateModel(at indexPath: IndexPath) {
            if let item = todoItems?[indexPath.row] {
                do {
                    try realm.write {
                        realm.delete(item)
                    }
                } catch {
                    print("Error deleting Item, \(error)")
                }
            }
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












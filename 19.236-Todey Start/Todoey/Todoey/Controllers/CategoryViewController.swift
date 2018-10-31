//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Chris Maltez on 10/29/18.
//  Copyright © 2018 Christopher Maltez. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {

    let realm = try! Realm() //code smell


    var categories = [Category]()

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //MARK: - TableView Datasource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)

        let category = categories[indexPath.row].name

        // Ternary Operator ==>
        // value = condition ? valueIfTrue : valueIfFalse

        return cell
    }

    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        performSegue(withIdentifier: "goToItems", sender: self)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController

        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }

    }

    //MARK: - Data Manipulation Methods
    func save(category: Category) {

        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving context \(error)")
        }

        tableView.reloadData()
    }

    func loadCategories() {

//        let request : NSFetchRequest<Category> = Category.fetchRequest()
//
//        do {
//
//            categories = try context.fetch(request)
//        } catch {
//            print("Error loading categories \(error)")
//        }
//
//        tableView.reloadData()



    }


    //MARK: - Add New Categories

      @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()

        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            //What will happen once the user clicks the Add Category Button on our UIAlert

            let newCategory = Category()
            newCategory.name = textField.text!

            self.categories.append(newCategory)

            self.save(category: newCategory)

        }
        alert.addAction(action)

        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new category"

        }


        present(alert, animated: true, completion: nil)
    }



}

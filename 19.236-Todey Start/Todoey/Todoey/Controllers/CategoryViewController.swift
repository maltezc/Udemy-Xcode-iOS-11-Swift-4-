//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Chris Maltez on 10/29/18.
//  Copyright © 2018 Christopher Maltez. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework


class CategoryViewController: SwipeTableViewController {

    let realm = try! Realm() //code smell


    var categories: Results<Category>?

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()

        tableView.separatorStyle = .none // removes lines between cells

    }
    //MARK: - TableView Datasource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return categories?.count ?? 1 // nil coalescing operator -- get count if not nil, otherwise use 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = super.tableView(tableView, cellForRowAt: indexPath)

        if let category = categories? [indexPath.row] {

            cell.textLabel?.text = category.name

            guard let categoryColor = UIColor(hexString: category.color, returnFlat: true) else {fatalError()}
//            cell.backgroundColor = UIColor(hexString: category.color ?? "25A4FE") // adds random colors from chameleon

            cell.backgroundColor = categoryColor


            cell.textLabel?.textColor = ContrastColorOf(categoryColor, returnFlat: true)


        }

        // Ternary Operator ==>
        // value = condition ? valueIfTrue : valueIfFalse
//        cell.delegate = self
        return cell
    }

    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        performSegue(withIdentifier: "goToItems", sender: self)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController

        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
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

        categories = realm.objects(Category.self)

        tableView.reloadData()
    }

    //Mark: - Delete Data From Swipe

    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("Error deleting category, \(error)")
            }
        }
    }


    //MARK: - Add New Categories

      @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()

        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            //What will happen once the user clicks the Add Category Button on our UIAlert

            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.color = UIColor.randomFlat.hexValue()
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




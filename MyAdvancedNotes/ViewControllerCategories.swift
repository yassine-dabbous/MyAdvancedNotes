//
//  ViewControllerCategories.swift
//  MyAdvancedNotes
//
//  Created by Yassine on 8/12/17.
//  Copyright © 2017 Yassine. All rights reserved.
//

import UIKit
import CoreData
class ViewControllerCategories: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var categoryInput: UITextField!
    @IBOutlet weak var categoriesTable: UITableView!
    
    var categories = [Categories]()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = categoriesTable.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].title
        return cell
    }
    
    func loadCategoriesFromDB(){
        let dbRequest:NSFetchRequest<Categories> = Categories.fetchRequest()
        do{
            categories = try context.fetch(dbRequest)
        }
        catch{
            print("can't load categories from DB")
        }
        categoriesTable.reloadData()
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        let newCategory = Categories(context: context)
        newCategory.title = categoryInput.text
        do{
            ad.saveContext()
            categoryInput.text = ""
        }
        catch{
            print("can't save category in db")
        }
        loadCategoriesFromDB() // to refresh table
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategoriesFromDB()
    }

}

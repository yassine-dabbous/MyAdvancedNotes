//
//  ViewControllerCreateNote.swift
//  MyAdvancedNotes
//
//  Created by Yassine on 8/12/17.
//  Copyright © 2017 Yassine. All rights reserved.
//

import UIKit
import CoreData
class ViewControllerCreateNote: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var descriptionInput: UITextView!
    @IBOutlet weak var categoriesPicker: UIPickerView!
    @IBOutlet weak var noteImage: UIImageView!
    
    var categories = [Categories]()
    var imagePicker:UIImagePickerController?
    var currentNote:Notes?
    
    func loadCategoriesFromDB(){
        let requestDb:NSFetchRequest<Categories> = Categories.fetchRequest()
        do{
            categories = try context.fetch(requestDb)
        }
        catch{
            print("can't load categories from DB")
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row].title
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            noteImage.image = image
        }
        imagePicker?.dismiss(animated: true)
    }
    @IBAction func btnImageChooser(_ sender: Any) {
        present(imagePicker!, animated: true)
    }
    
    
    
    
    @IBAction func btnSave(_ sender: Any) {
        var newNote = Notes(context: context)
        if currentNote != nil { // in modification case
            newNote = currentNote!
        }
        newNote.title = titleInput.text
        newNote.date = NSDate()
        newNote.text = descriptionInput.text
        newNote.image = noteImage.image
        newNote.category = categories[categoriesPicker.selectedRow(inComponent: 0)]
        do{
            ad.saveContext()
            descriptionInput.text = ""
            titleInput.text = ""
            dismiss(animated: true)
        }
        catch{
            print("can't save new note in db")
        }
    }
    
    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategoriesFromDB()
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
        
        
        if currentNote != nil {
            titleInput.text = currentNote?.title
            descriptionInput.text = currentNote?.text
            descriptionInput.text = currentNote?.text
            noteImage.image = currentNote?.image as! UIImage
            
            var i:Int = 0
            for category in categories {
                if category == currentNote?.category {
                    categoriesPicker.selectedRow(inComponent: i)
                }
                i += 1
            }
        }
    }

}

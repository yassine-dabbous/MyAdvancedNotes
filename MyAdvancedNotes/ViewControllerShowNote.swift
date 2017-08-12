//
//  ViewControllerShowNote.swift
//  MyAdvancedNotes
//
//  Created by Yassine on 8/11/17.
//  Copyright © 2017 Yassine. All rights reserved.
//

import UIKit

class ViewControllerShowNote: UIViewController {
    
    var currentNote:Notes?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var descriptionView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = currentNote?.title
        categoryLabel.text = currentNote?.category?.title
        descriptionView.text = currentNote?.text
        image.image = currentNote?.image as? UIImage
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy M/d h:mm a"
        dateLabel.text = formatter.string(from: currentNote?.date! as! Date)
    }
    
    
    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func editBtn(_ sender: Any) {
        performSegue(withIdentifier: "editNote", sender: currentNote)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editNote" {
            if let destination = segue.destination as? ViewControllerCreateNote{
                if let note = sender as? Notes{
                    destination.currentNote = note
                }
            }
        }
    }
    
    @IBAction func btnDelete(_ sender: Any) {
        do{
            ad.delete(currentNote)
            dismiss(animated: true)
        }
        catch{
            print("can't delete this note from db")
        }
    }
    
    

    
}

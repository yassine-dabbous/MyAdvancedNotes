//
//  NotesTableViewCell.swift
//  MyAdvancedNotes
//
//  Created by Yassine on 8/11/17.
//  Copyright © 2017 Yassine. All rights reserved.
//

import UIKit

class NotesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descView: UITextView!
    @IBOutlet weak var cellImage: UIImageView!
    
    
    func setCell(note:Notes){
        titleLabel.text = note.title
        descView.text = note.text
        cellImage.image = note.image as? UIImage
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/DD/yy"
        dateLabel.text = formatter.string(from: note.date! as! Date)
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

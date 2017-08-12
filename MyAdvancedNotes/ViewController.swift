//
//  ViewController.swift
//  MyAdvancedNotes
//
//  Created by Yassine on 8/10/17.
//  Copyright © 2017 Yassine. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var notesTable: UITableView!
    var controller:NSFetchedResultsController<Notes>?
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller?.sections{
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:NotesTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as? NotesTableViewCell)!
        configureCell(cell: cell, indexPath: indexPath)
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = controller?.object(at: indexPath)
        performSegue(withIdentifier: "showNote", sender: note)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNote"{
            if let distination = segue.destination as? ViewControllerShowNote{
                if let note = sender as? Notes{
                    distination.currentNote = note
                }
            }
        }
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNotesFromDB()
    }

    func loadNotesFromDB(){
        let request:NSFetchRequest<Notes> = Notes.fetchRequest()
        let sort = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sort]
        controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller?.delegate = self
        do{
            try controller?.performFetch()
        }catch{
            print("cant fetch with controller from db")
        }
    }
    
    func configureCell(cell:NotesTableViewCell, indexPath: IndexPath ){
        let note = controller?.object(at: indexPath)
        cell.setCell(note: note!)
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        notesTable.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        notesTable.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        // data fetch
        switch(type) {
            
        case.insert:
            if let indexPath = newIndexPath {
                notesTable.insertRows(at: [indexPath], with: .fade)
            }
            break
        case.delete:
            if let indexPath = indexPath {
                notesTable.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case.update:
            if let indexPath = indexPath {
                let cell = notesTable.cellForRow(at: indexPath) as! NotesTableViewCell
                configureCell(cell: cell, indexPath: indexPath )
            }
            break
        case.move:
            if let indexPath = indexPath {
                notesTable.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                notesTable.insertRows(at: [indexPath], with: .fade)
            }
            break
            
        }
    }

}


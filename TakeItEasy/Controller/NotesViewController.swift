//
//  NotesViewController.swift
//  TakeItEasy
//
//  Created by Saul on 1/13/25.
//

import UIKit

class NotesViewController: UIViewController{

    
    @IBOutlet weak var viewForTable: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var notesList : [Note] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        notesList = DBHelper.dbhelper.fetchAllNotesByAccount(account_id: 1)
        notesList.sort {$0.timeLastEdit! > $1.timeLastEdit!}
        tableView.reloadData()
    }
    
    func setupUI(){
        viewForTable.layer.cornerRadius = CGRectGetWidth(viewForTable.frame) / 10
        
    }

    @IBAction func addNewNote(_ sender: Any) {
        let note = DBHelper.dbhelper.insertNote(accountID: 1)
        if note != nil {
            notesList.insert(note!, at: 0)
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
        if (segue.identifier == "noteSegue") {
            let noteView = segue.destination as! NoteViewController
            let note = sender as! Note?
            noteView.note = note
        }
    }
}

extension NotesViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DBHelper.dbhelper.deleteNote(id: notesList[indexPath.section].id!)
            notesList.remove(at: indexPath.section)
            tableView.deleteSections([indexPath.section], with: .fade)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return notesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notesCell", for: indexPath) as! NotesTableViewCell
        cell.title?.text = notesList[indexPath.section].title
        cell.subtitle?.text = "Lasted edited: " + (notesList[indexPath.section].timeLastEdit?.ISO8601Format())!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "noteSegue", sender: notesList[indexPath.section])
        
    }
}

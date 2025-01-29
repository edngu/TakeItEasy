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
    @IBOutlet weak var username: UILabel!
    var notesList : [Note] = []
    var searchData : [Note] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
        self.title = "Notes"

        username.text = GlobalData.shared.signedInAccount?.email
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tabBarItem.image = UIImage(systemName: "note")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        notesList = DBHelper.dbhelper.fetchAllNotesByAccount(account_id: (GlobalData.shared.signedInAccount?.id)!)
        notesList.sort {$0.timeLastEdit! > $1.timeLastEdit!}
        searchData = notesList
        tableView.reloadData()
    }
    
    func setupUI(){
        viewForTable.layer.cornerRadius = 30
        
    }

    @IBAction func addNewNote(_ sender: Any) {
        let note = DBHelper.dbhelper.insertNote(accountID: (GlobalData.shared.signedInAccount?.id)!)
        if note != nil {
            notesList.insert(note!, at: 0)
            searchData = notesList
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
    
    @IBAction func logOut(_ sender: Any) {
        
        if let vcA = self.storyboard?.instantiateViewController(withIdentifier: "logincontroller") as? LoginViewController {
            
            self.view.window?.rootViewController = vcA
            self.view.window?.makeKeyAndVisible()
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
            searchData.remove(at: indexPath.section)
            tableView.deleteSections([indexPath.section], with: .fade)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return searchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notesCell", for: indexPath) as! NotesTableViewCell
        cell.title?.text = searchData[indexPath.section].title
        cell.subtitle?.text = "Lasted edited: " + (searchData[indexPath.section].timeLastEdit?.ISO8601Format())!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "noteSegue", sender: searchData[indexPath.section])
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
}

extension NotesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchData = searchText.isEmpty ? notesList : notesList.filter {
            (note: Note) -> Bool in
            return note.title?.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        tableView.reloadData()
    }
    
}

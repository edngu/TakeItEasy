//
//  NotesViewController.swift
//  TakeItEasy
//
//  Created by Saul on 1/13/25.
//

import UIKit

class NotesViewController: UIViewController{

    
    @IBOutlet weak var viewForTable: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
        
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setupUI(){
        viewForTable.layer.cornerRadius = CGRectGetWidth(viewForTable.frame) / 10
        viewForTable.backgroundColor = .blue
    }

}

extension NotesViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notesCell", for: indexPath) as! NotesTableViewCell
        cell.textLabel?.text = "Notes"
        return cell
    }
}

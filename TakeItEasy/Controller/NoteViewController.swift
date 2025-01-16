//
//  NoteViewController.swift
//  TakeItEasy
//
//  Created by Saul on 1/13/25.
//

import UIKit

class NoteViewController: UIViewController {


    @IBOutlet weak var titleBackdropView: UIView!
    @IBOutlet weak var textBackdropView: UIView!
    @IBOutlet weak var noteName: UITextField!
    @IBOutlet weak var text: UITextView!
    
    var note : Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        noteName.text = note?.title
        text.text = note?.content
    }
    
    
    // Save notes here temporarily. Potentially add save button.
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let id = note?.id {
            DBHelper.dbhelper.updateNoteTitle(id: id, title: noteName.text! as NSString)
            DBHelper.dbhelper.updateNoteContent(id: id, content: text.text! as NSString)
        } else {
            print("Note changes not saved")
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func saveNote(_ sender: Any) {
    }
    
    func setupUI(){
        noteName.layer.cornerRadius = 20
        text.layer.cornerRadius = 20
        titleBackdropView.layer.cornerRadius = 20
        textBackdropView.layer.cornerRadius = 20
        
    }

}

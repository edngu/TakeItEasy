//
//  NoteViewController.swift
//  TakeItEasy
//
//  Created by Saul on 1/13/25.
//

import UIKit

class NoteViewController: UIViewController {


    @IBOutlet weak var textBackdropView: UIView!
    //@IBOutlet weak var noteName: UITextField!
    @IBOutlet weak var text: UITextView!
    @IBOutlet weak var username: UILabel!
    var note : Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //noteName.text = note?.title
        text.text = note?.content
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let id = note?.id {
            DBHelper.dbhelper.updateNoteTitle(id: id, title: getFirstLine() as NSString)
            DBHelper.dbhelper.updateNoteContent(id: id, content: text.text! as NSString)
        } else {
            print("Note changes not saved")
        }
        
    }
    
    
    func getFirstLine() -> String {
        guard !text.text.isEmpty else {
            return ""
        }
        
        var firstLine : String = ""
        
        if let end = text.text.firstIndex(of: "\n") {
            firstLine = text.text.substring(to: end)
        } else if text.text.count > 30 {
            firstLine = text.text.substring(to: text.text.index(text.text.startIndex, offsetBy: 30))
        } else {
            firstLine = text.text
        }
        
        return firstLine
    }
    

    
    func setupUI(){
        text.layer.cornerRadius = 30
        textBackdropView.layer.cornerRadius = 30
        
    }

}

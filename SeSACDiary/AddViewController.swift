//
//  AddViewController.swift
//  SeSACDiary
//
//  Created by 김정민 on 2021/11/01.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController {
    
    let localRealm = try! Realm()
    var tasks: Results<UserDiary>!

    @IBOutlet var titleText: UITextView!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var contentTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.title = "일기 작성"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        
        tasks = localRealm.objects(UserDiary.self)
        print("Realm is loacted at: ", localRealm.configuration.fileURL!)
        
    }
    
    @objc func closeButtonClicked(){
        self.dismiss(animated: true, completion: nil)
    }
    
   
    @IBAction func datePickerButton(_ sender: UIDatePicker) {
        
        print(datePicker.date)
        print(sender.date)
        
        let format = DateFormatter()
        format.dateFormat = "yy년 MM월 dd일"
        
        let value = format.string(from: sender.date)
        print(value)

    }
    
    
    @objc func saveButtonClicked() {
        
        let task = UserDiary(diaryTitle:titleText.text!,  content: contentTextField.text!, writeDate: Date(), regDate: Date())
        try! localRealm.write{
            localRealm.add(task)
        }
        
        print(task)
        
    }
    
    
    

}


extension AddViewController : UITextViewDelegate {
    
    
}

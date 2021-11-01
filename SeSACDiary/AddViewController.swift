//
//  AddViewController.swift
//  SeSACDiary
//
//  Created by 김정민 on 2021/11/01.
//

import UIKit

class AddViewController: UIViewController {
    
    
    @IBOutlet var titleText: UITextView!
    @IBOutlet var datePicker: UIDatePicker!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.title = "일기 작성"
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: nil)
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
    
    
    

}


extension AddViewController : UITextViewDelegate {
    
    
}

//
//  DatePickerViewController.swift
//  SeSACDiary
//
//  Created by 김정민 on 2021/11/05.
//

import UIKit

class DatePickerViewController: UIViewController {

    @IBOutlet var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker.preferredDatePickerStyle = .wheels
    }
    

}

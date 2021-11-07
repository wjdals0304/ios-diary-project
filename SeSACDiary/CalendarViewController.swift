//
//  CalendarViewController.swift
//  SeSACDiary
//
//  Created by 김정민 on 2021/11/06.
//

import UIKit
import FSCalendar
import RealmSwift

class CalendarViewController: UIViewController {

    @IBOutlet var calendarView: FSCalendar!
    
    let localRealm  = try! Realm()
    
    var tasks: Results<UserDiary>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarView.delegate = self
        calendarView.dataSource = self

        tasks = localRealm.objects(UserDiary.self )
    }


}


extension CalendarViewController: FSCalendarDelegate , FSCalendarDataSource {
    
//    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
//        return "title"
//    }
//
//    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
//        return "subtitle"
//    }
//
//    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
//        return UIImage(systemName: "star")
//    }
    
    //Date: 시분초까지 모두 동일해야 함.
    //1.영국 표준시 기준으로 표기
    //2. 데이트 포맷터
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        // 11/2 3개의 일기라면 3개를 , 없다면 x. 1개를 1개
        var count = 0        
        for i in tasks {
            print(i)
            if i.writeDate == date {
                count += 1
            }
        }
        
        return count
        
//        return tasks.filter("writeDate = %@",date).count
        
//        let format = DateFormatter()
//        format.dateFormat = "yyyyMMdd"
//        let test = "20211103"
//
//        if format.date(from: test) == date {
//            return 3
//        } else {
//            return 1
//        }
        
    }
    
    
    
}

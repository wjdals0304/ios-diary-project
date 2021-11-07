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
    @IBOutlet var contentTextField: UITextView!
    
    @IBOutlet var contentImage: UIImageView!
    @IBOutlet var dateButton: UIButton!
    
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
    

    // datePicker
//    @IBAction func datePickerButton(_ sender: UIDatePicker) {
//
//        print(datePicker.date)
//        print(sender.date)
//
//        let format = DateFormatter()
//        format.dateFormat = "yy년 MM월 dd일"
//
//        let value = format.string(from: sender.date)
//        print(value)
//
//    }
    
    
    @objc func saveButtonClicked() {
        
        let format = DateFormatter()
        format.dateFormat = "yyyy년 MM월 dd일"
        
        guard let date = dateButton.currentTitle ,  let value = format.date(from: date) else { return }
        
        print("bbbbbbb")
        print(date)
        print(value)
        
        let task = UserDiary(diaryTitle:titleText.text!,  content: contentTextField.text!, writeDate: value, regDate: Date())
        
        try! localRealm.write{
            localRealm.add(task)
            saveImageToDocumentDirectory(imageName: "\(task._id).jpg", image: contentImage.image!)
        }
        
        
    }
    
    func saveImageToDocumentDirectory(imageName: String , image : UIImage ) {
        
        // 1. 이미지 저장할 경로 설정 : 도큐먼트 폴더 (.documentDirectory), fileManager
        // destop/jmkim/ios/folder
        guard let documentDirctory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        // 2. 이미지 파일 이름 & 최종 경로 설정
        //desktop/jack/ios/folder/222.png
        let imageURL = documentDirctory.appendingPathComponent(imageName)
        
        //3. 이미지 압축
        guard let data = image.jpegData(compressionQuality: 0.2) else { return }
        
        //4. 이미지 저장: 동일한 경로에 이미지를 저장하게 될 경우, 덮어쓰기
        // 4-1. 이미지 경로 여부 확인
        if FileManager.default.fileExists(atPath: imageURL.path) {
            
            //4-2. 기존 경로에 있는 이미지 삭제
            do {
                try FileManager.default.removeItem(at: imageURL)
                print("이미지 삭제 완료")
            } catch {
                print("이미지를 삭제하지 못했습니다")
            }
        
        }
        
        // 5. 이미지를 도큐먼트에 저장
        do {
            try data.write(to: imageURL)
        } catch {
            print("이미지 저장 못함")
        }
    }
    
    @IBAction func dateButtonClicked(_ sender: UIButton) {

        let alert = UIAlertController(title: "날짜 선택", message: "날짜를 선택해주세요", preferredStyle: .alert)
        //alert customizing
    
//        let contentView = DatePickerViewController()
        guard let contentView = self.storyboard?.instantiateViewController(withIdentifier: "DatePickerViewController") as? DatePickerViewController else {
            return
        }
        contentView.view.backgroundColor = .clear
//        contentView.preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        contentView.preferredContentSize.height = 200
        alert.setValue(contentView, forKey: "contentViewController")
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        let ok = UIAlertAction(title: "확인", style: .default ) { _ in
            
            let format = DateFormatter()
            format.dateFormat = "yyyy년 MM월 dd일"
            let value = format.string(from: contentView.datePicker.date)
            
            // 확인 버튼을 눌렀을 때 버튼의 타이틀 변경
            self.dateButton.setTitle(value, for: .normal)
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert,animated: true,completion: nil )
    }
    
    

}


extension AddViewController : UITextViewDelegate {
    
    
}

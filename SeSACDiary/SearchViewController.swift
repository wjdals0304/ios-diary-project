//
//  SearchViewController.swift
//  SeSACDiary
//
//  Created by 김정민 on 2021/11/01.
//

import UIKit
import RealmSwift

class SearchViewController: UIViewController {
    
    @IBOutlet var searchTableView: UITableView!
    
    let localRealm = try! Realm()
    var tasks: Results<UserDiary>!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = LocalizableStrings.search.localized
        
        // delegate
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryTitle", ascending: false)
    
//        print(localRealm.configuration.fileURL)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searchTableView.reloadData()
    }
    
    
    // 도큐먼트 폴더 경로 - > 이미지 찾기 -> UIImage -> UIImageView
    func loadImageFromDocumentDirectory(imageName: String) -> UIImage? {
        
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let directoryPath = path.first {
            
            let imageURL = URL(fileURLWithPath: directoryPath).appendingPathComponent(imageName)
            return UIImage(contentsOfFile: imageURL.path)
        }
        
        return nil
        
    }
   
    func deleteImageFromDocmentDirectory(imageName : String){
        
        // 1. 이미지 저장할 경로 설정 : 도큐먼트 폴더 (.documentDirectory), fileManager
        guard let documentDirctory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        // 2. 이미지 파일 이름 & 최종 경로 설정
        let imageURL = documentDirctory.appendingPathComponent(imageName)
        
        
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
    }

}


extension SearchViewController : UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let taskToUpdate = tasks[indexPath.row]
        
        try! localRealm.write {
            taskToUpdate.diaryTitle = "새롭게 수정해봅니다."
            taskToUpdate.content = "현대차는 전기차"
            
            tableView.reloadData()
        }
        
        // 2. 일괄 수정
//        try! localRealm.write{
//            tasks.setValue(Date(), forKey: "writeDate")
//            tasks.setValue("새롭게 일기 쓰기", forKey: "diaryTitle")
//            tableView.reloadData()
//        }
        
        // 3. 수정 : pk 기준으로 수정할 때 사용 ( 권장 X)
        //  try! localRealm.write{
        //  let update = UserDiary(value: [ "_id" : taskToUpdate._id , "diaryTitle": "애만 바꾸고 싶어"])
        //  localRealm.add(update,update: .modified)
        //  tableView.reloadData()
        //  }
        
        
        // 4.
        //  try! localRealm.write {
        //            localRealm.create(UserDiary.self, value: [ "_id" : taskToUpdate._id , "diaryTitle": "애만 바꾸고 싶어"], update: .modified)
        //            tableView.reloadData()
        //        }
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let row = tasks[indexPath.row]
        
        try! localRealm.write{
            
            deleteImageFromDocmentDirectory(imageName: "\(row._id).jpg")
            localRealm.delete(row)
            tableView.reloadData()
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
        let row = tasks[indexPath.row]
        
        cell.resultImage.image = loadImageFromDocumentDirectory(imageName: "\(row._id).jpg")
        cell.titleLable?.text = row.diaryTitle
        
        let format = DateFormatter()
        format.dateFormat = "yyyy년 MM월 dd일"
        cell.dateLable.text = format.string(from: row.writeDate)
        cell.contentLable?.text = row.content
        
        return cell
    }
    
}

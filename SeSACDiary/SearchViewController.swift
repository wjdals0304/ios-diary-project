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
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searchTableView.reloadData()
    }
   


}


extension SearchViewController : UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
        let row = tasks[indexPath.row]
        
        cell.titleLable?.text = row.diaryTitle
        cell.dateLable?.text = row.content
        cell.contentLable?.text = "\(row.writeDate)"
        
        return cell
    }
    
    
    
}

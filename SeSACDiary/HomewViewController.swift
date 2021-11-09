//
//  HomewViewController.swift
//  SeSACDiary
//
//  Created by 김정민 on 2021/11/01.
//

import UIKit

class HomewViewController: UIViewController {
    
    
    @IBOutlet var tableView: UITableView!
    
    let array = [
        Array(repeating: "a", count: 20),
        Array(repeating: "b", count: 10),
        Array(repeating: "c", count: 15),
        Array(repeating: "d", count: 2),
        Array(repeating: "e", count: 13),
        Array(repeating: "f", count: 22),
        Array(repeating: "g", count: 13),
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = LocalizableStrings.home.localized
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func AddviewButton(_ sender: UIBarButtonItem) {
                
        
        // storyboard reference 사용할 경우에
        // 1.stoyboard
        // let sb = UIStoryboard(name: "Content", bundle: nil)
        // 2. addviewcontroller
        // let vc = sb..instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        
        let nav = UINavigationController(rootViewController: vc)
        
        
        nav.modalPresentationStyle = .fullScreen
        
        self.present(nav,animated: true , completion: nil)
    }
    
}

extension HomewViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count

    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        
        cell.data = array[indexPath.row]
        cell.collectionView.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return indexPath.row == 1 ? 300 : 300


    }
    
}



//
//  HomewViewController.swift
//  SeSACDiary
//
//  Created by 김정민 on 2021/11/01.
//

import UIKit

class HomewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = LocalizableStrings.home.localized

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

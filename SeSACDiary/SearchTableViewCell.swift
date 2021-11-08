//
//  SearchTableViewCell.swift
//  SeSACDiary
//
//  Created by 김정민 on 2021/11/01.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet var titleLable: UILabel!
    @IBOutlet var dateLable: UILabel!
    @IBOutlet var contentLable: UILabel!
    @IBOutlet var resultImage: UIImageView!
    
    func configureCell(row: UserDiary) {
        

       titleLable?.text = row.diaryTitle
        
        let format = DateFormatter()
        format.dateFormat = "yyyy년 MM월 dd일"
        dateLable.text = format.string(from: row.writeDate)
        contentLable?.text = row.content
        
        
    }
    
    
    
    static let identifier = "SearchTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }



}


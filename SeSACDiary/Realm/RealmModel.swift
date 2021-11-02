//
//  RealmModel.swift
//  SeSACDiary
//
//  Created by 김정민 on 2021/11/02.
//

import Foundation
import RealmSwift

//UserDiary: 테이블 이름
//@Persisted : 컬럼
class UserDiary: Object {
    
    @Persisted var diaryTitle: String // 제목(필수)
    @Persisted var content : String? // 내용(옵션)
    @Persisted var writeDate = Date() // 작성날짜(필수)
    @Persisted var regDate = Date() // 등록일(필수)
    @Persisted var favorite: Bool // 즐겨찾기 기능(필수)
    
    // pk
    @Persisted(primaryKey: true) var _id : ObjectId
    
    convenience init(diaryTitle : String , content: String? , writeDate: Date,regDate:Date){
        self.init()
        
        self.diaryTitle = diaryTitle
        self.content = content
        self.writeDate = writeDate
        self.regDate = regDate
        self.favorite = false
    }
        
    
    
}




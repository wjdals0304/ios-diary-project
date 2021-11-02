//
//  LocalizableString.swift
//  SeSACDiary
//
//  Created by 김정민 on 2021/11/02.
//

import Foundation


enum LocalizableStrings : String {
    
    case home
    case search
    
    var localized : String {
        return self.rawValue.localized() // Localizable.strings
    }
     

}

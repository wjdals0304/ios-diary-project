//
//  String+Extension.swift
//  SeSACDiary
//
//  Created by 김정민 on 2021/11/02.
//


import Foundation

extension String {
    
    
    func localized(tableName : String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName , bundle: .main , value: "", comment: "")
    }

    
    
}

//
//  User_name.swift
//  UberCook
//
//  Created by 超 on 2020/9/10.
//

import Foundation

struct User_name:Codable {
    var user_name:String?
    
    public init(_ user_name:String){
        self.user_name = user_name
    }
}

//
//  ChefLeader.swift
//  UberCook
//
//  Created by 超 on 2020/8/30.
//
import Foundation
import UIKit

class ChefLeader: Codable {
    var user_no: String?
    var chef_no: String?
    var user_name: String?
    var user_si: String?
    
    public init(_ user_no:String, _ chef_no:String, _ user_name:String, _ user_si:String){
        self.user_no = user_no
        self.chef_no = chef_no
        self.user_name = user_name
        self.user_si = user_si
    }
}

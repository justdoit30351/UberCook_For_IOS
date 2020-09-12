//
//  Collection.swift
//  UberCook
//
//  Created by 超 on 2020/9/12.
//

import Foundation

struct Collection:Codable {
    var chef_no:String
    var recipe_no:String
    var recipe_title:String
    var recipe_con:String
    var recipe_point:Int
    
    
    public init(_ chef_no:String, _ recipe_no:String, _ recipe_title:String, _ recipe_con:String, _ recipe_point:Int){
        self.chef_no = chef_no
        self.recipe_no = recipe_no
        self.recipe_title = recipe_title
        self.recipe_con = recipe_con
        self.recipe_point = recipe_point
    }
}

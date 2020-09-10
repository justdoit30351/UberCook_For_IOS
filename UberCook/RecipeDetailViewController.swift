//
//  RecipeDetailViewController.swift
//  UberCook
//
//  Created by 超 on 2020/9/1.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    let url_server = URL(string: common_url + "UberCook_Servlet")
    var fullScreenSize :CGSize!
    let fileManager = FileManager()
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeConLabel: UILabel!
    @IBOutlet weak var recipePointLabel: UILabel!
    @IBOutlet weak var chefIconImageView: UIImageView!
    @IBOutlet weak var recipeImageview: UIImageView!
    @IBOutlet weak var chefNameLabel: UILabel!
//    var user_name:[User]?
//    var userName:String
    var recipe:Recipe?
    var user_name:User_name?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullScreenSize = UIScreen.main.bounds.size
        recipeConLabel.text = recipe?.recipe_con
        recipeTitleLabel.text = recipe?.recipe_title
        recipePointLabel.text = "$ \(String(recipe?.recipe_point ?? 0))"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showChefIcon()
        showRecipeImage()
        showChefName()
    }
    
    
    
    func showChefIcon(){
        var requestParam = [String: Any]()
        requestParam["action"] = "getUserImageForRecipeDetail"
        requestParam["chef_no"] = recipe?.chef_no
        requestParam["imageSize"] = 240
        var image: UIImage?
//        let imageUrl = fileInCaches(fileName: recipe.)
//        if self.fileManager.fileExists(atPath: imageUrl.path) {
//            if let imageCaches = try? Data(contentsOf: imageUrl) {
//                image = UIImage(data: imageCaches)
//                DispatchQueue.main.async {
//                    self.chefIconImageView.image = image
//                }
//            }
//        }else{
            executeTask(url_server!, requestParam) { (data, response, error) in
                //            print("input: \(String(data: data!, encoding: .utf8)!)")
                if error == nil {
                    if data != nil {
                        image = UIImage(data: data!)
                    }
                    if image == nil {
                        image = UIImage(named: "noImage.jpg")
                    }
                    DispatchQueue.main.async {
                        self.chefIconImageView.image = image
                    }
                } else {
                    print(error!.localizedDescription)
                }
            }
//        }
    }
    
    func showRecipeImage(){
        var requestParam = [String: Any]()
        requestParam["action"] = "getRecipeImage"
        requestParam["recipe_no"] = recipe?.recipe_no
        requestParam["imageSize"] = 720
        var image: UIImage?
        let imageUrl = fileInCaches(fileName: recipe?.recipe_no ?? "")
        if self.fileManager.fileExists(atPath: imageUrl.path) {
            if let imageCaches = try? Data(contentsOf: imageUrl) {
                image = UIImage(data: imageCaches)
                DispatchQueue.main.async {
                    self.recipeImageview.image = image
                }
            }
        }else{
        executeTask(url_server!, requestParam) { (data, response, error) in
            //            print("input: \(String(data: data!, encoding: .utf8)!)")
            if error == nil {
                if data != nil {
                    image = UIImage(data: data!)
                    DispatchQueue.main.async {
                        self.recipeImageview.image = image
                    }
                    if let image = image?.jpegData(compressionQuality: 1.0) {
                        try? image.write(to: imageUrl, options: .atomic)
                    }
                }
                if image == nil {
                    image = UIImage(named: "noImage.jpg")
                    DispatchQueue.main.async {
                        self.recipeImageview.image = image
                    }
                }
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    }
    
    func showChefName(){
//        let dataUrl = fileInCaches(fileName: recipe?.chef_no ?? "")
//        if fileManager.fileExists(atPath: dataUrl.path) {
//            if let name = NSDictionary(contentsOf: dataUrl) as? [String: String] {
//                if let user_name = name["name"] {
//                    chefNameLabel.text = user_name
//                }
//            }
        
        var requestParam = [String: Any]()
        requestParam["action"] = "getUserNameforRecipeDetail"
        requestParam["chef_no"] = recipe?.chef_no
        executeTask(url_server!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    print("input: \(String(data: data!, encoding: .utf8)!)")
//                    if let result = try? JSONDecoder().decode([User_name].self, from: data!){
                        DispatchQueue.main.async {
                            self.chefNameLabel.text = "\(String(decoding: data!, as: UTF8.self))"
                        }
                    }
                }
            }
        }
}

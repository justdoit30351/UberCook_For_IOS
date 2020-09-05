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
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeConLabel: UILabel!
    @IBOutlet weak var recipePointLabel: UILabel!
    @IBOutlet weak var chefIconImageView: UIImageView!
    @IBOutlet weak var recipeImageview: UIImageView!
    @IBOutlet weak var chefNameLabel: UILabel!
    var user_name = [User]()
    
    var recipe:Recipe?
    
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
    }
    
    func showRecipeImage(){
        print("showRecipeImage")
        var requestParam = [String: Any]()
        requestParam["action"] = "getRecipeImage"
        requestParam["recipe_no"] = recipe?.recipe_no
        requestParam["imageSize"] = 720
        var image: UIImage?
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
                    self.recipeImageview.image = image
                }
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    func showChefName(){
        print("showchefName")
        var requestParam = [String: Any]()
        requestParam["action"] = "getUserNameforRecipeDetail"
        requestParam["chef_no"] = recipe?.chef_no
        executeTask(url_server!, requestParam) { (data, response, error) in
            let decoder = JSONDecoder()
            if error == nil {
                if data != nil {
                    print("input: \(String(data: data!, encoding: .utf8)!)")
                    if let result = try? decoder.decode([User].self, from: data!){
                        self.user_name = result
                        DispatchQueue.main.async {
                            let userName = self.user_name[0]
//                            self.chefNameLabel.text = userName.user_name
                            print(self.chefNameLabel.text ?? "error")
                        }
                    }
                }
            }
        }
    }
    
    
}

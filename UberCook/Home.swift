//
//  Home.swift
//  UberCook
//
//  Created by 超 on 2020/8/30.
//

import UIKit
import Foundation

class Home: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionView2: UICollectionView!
    
    let url_server = URL(string: common_url + "UberCook_Servlet")
    let fileManager = FileManager()
    var chefLeaderList = [ChefLeader]()
    var reciepLeaderList = [Recipe]()
    var fullScreenSize :CGSize!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullScreenSize = UIScreen.main.bounds.size
        collectionView.backgroundColor = UIColor.white
        collectionView2.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showAllChef()
        showAllRecipe()
    }
    
    func showAllChef(){
        var requestParam = [String: Any]()
        requestParam["action"] = "getChefLeader"
        requestParam["getChefLeaderType"] = "ChefAll"
        executeTask(url_server!, requestParam) { (data, response, error) in
            let decoder = JSONDecoder()
            if error == nil {
                if data != nil {
                    //                    print("input: \(String(data: data!, encoding: .utf8)!)")
                    if let result = try? decoder.decode([ChefLeader].self, from: data!){
                        self.chefLeaderList = result
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    func showAllRecipe(){
        var requestParam = [String: Any]()
        requestParam["action"] = "getRecipes"
        requestParam["getRecipeLeaderType"] = "ChefAll"
        executeTask(url_server!, requestParam) { (data, response, error) in
            //            let decoder = JSONDecoder()
            if error == nil {
                if data != nil {
                    //                    print("input: \(String(data: data!, encoding: .utf8)!)")
                    if let result = try? JSONDecoder().decode([Recipe].self, from: data!){
                        self.reciepLeaderList = result
                        DispatchQueue.main.async {
                            self.collectionView2.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView.tag {
        case 0:
            return chefLeaderList.count
        default:
            return reciepLeaderList.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView.tag {
        case 0:
            let chefBlog = self.storyboard?.instantiateViewController(withIdentifier: "BlogViewController") as! BlogViewController
            let chef = chefLeaderList[indexPath.row]
            chefBlog.chefLeader = chef
            self.navigationController?.pushViewController(chefBlog, animated: true)
        default:
            let recipeDetail = self.storyboard?.instantiateViewController(withIdentifier: "RecipeDetailViewController") as! RecipeDetailViewController
            let recipe = reciepLeaderList[indexPath.row]
            recipeDetail.recipe = recipe
            self.navigationController?.pushViewController(recipeDetail, animated: true)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView.tag {
        case 0:
            let chefLeader = chefLeaderList[indexPath.row]
            let dataUrl = fileInCaches(fileName: chefLeader.chef_no!)
            var name = [String: String]()
            name["name"] = chefLeader.user_name
            NSDictionary(dictionary: name).write(to: dataUrl, atomically: true)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCollectionViewCell
            cell.layer.cornerRadius = cell.frame.height/20
            var requestParam = [String: Any]()
            requestParam["action"] = "getUserImage"
            requestParam["user_no"] = chefLeader.user_no
            requestParam["imageSize"] = cell.frame.width
            var image: UIImage?
            let imageUrl = fileInCaches(fileName: chefLeader.user_no!)
            if self.fileManager.fileExists(atPath: imageUrl.path) {
                if let imageCaches = try? Data(contentsOf: imageUrl) {
                    image = UIImage(data: imageCaches)
                    DispatchQueue.main.async {
                        cell.HomeChefImageView.image = image
                    }
                }
            }else {
                executeTask(url_server!, requestParam) { (data, response, error) in
//                    print("input: \(String(data: data!, encoding: .utf8)!)")
                    if error == nil {
                        if data != nil {
                            image = UIImage(data: data!)
                            DispatchQueue.main.async {
                                cell.HomeChefImageView.image = image
                            }
                            if let image = image?.jpegData(compressionQuality: 1.0) {
                                try? image.write(to: imageUrl, options: .atomic)
                            }
                        }
                        if image == nil {
                            image = UIImage(named: "noImage.jpg")
                            DispatchQueue.main.async {
                                cell.HomeChefImageView.image = image
                            }
                        }
                    } else {
                        print(error!.localizedDescription)
                    }
                }
            }
            return cell
        default:
            let recipeLeader = reciepLeaderList[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath) as! HomeCollectionViewCell
            cell.layer.cornerRadius = cell.frame.height/20
            var requestParam = [String: Any]()
            requestParam["action"] = "getRecipeImage"
            requestParam["recipe_no"] = recipeLeader.recipe_no
            requestParam["imageSize"] = 720
            var image: UIImage?
            let imageUrl = fileInCaches(fileName: recipeLeader.recipe_no!)
            if self.fileManager.fileExists(atPath: imageUrl.path) {
                if let imageCaches = try? Data(contentsOf: imageUrl) {
                    image = UIImage(data: imageCaches)
                    DispatchQueue.main.async {
                        cell.HomeRecipeImageView.image = image
                    }
                }
            }else{
                executeTask(url_server!, requestParam) { (data, response, error) in
//                    print("input: \(String(data: data!, encoding: .utf8)!)")
                    if error == nil {
                        if data != nil {
                            image = UIImage(data: data!)
                            DispatchQueue.main.async {
                                cell.HomeRecipeImageView.image = image
                            }
                            if let image = image?.jpegData(compressionQuality: 1.0) {
                                try? image.write(to: imageUrl, options: .atomic)
                            }
                        }
                        if image == nil {
                            image = UIImage(named: "noImage.jpg")
                            DispatchQueue.main.async {
                                cell.HomeRecipeImageView.image = image
                            }
                        }
                        
                    } else {
                        print(error!.localizedDescription)
                    }
                }
            }
            return cell
        }
    }
}

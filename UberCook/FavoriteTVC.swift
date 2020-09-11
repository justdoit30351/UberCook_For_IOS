//
//  FavoriteTVC.swift
//  UberCook
//
//  Created by 超 on 2020/9/11.
//

import UIKit

class FavoriteTVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let userDefault = UserDefaults()
    let url_server = URL(string: common_url + "UberCook_Servlet")
    var track = [Track]()


    override func viewDidLoad() {
        super.viewDidLoad()
        getTrack()
    }
    
    func getTrack(){
        let user_no = userDefault.value(forKey: "user_no")
        var requestParam = [String: Any]()
        requestParam["action"] = "getFollow"
        requestParam["user_no"] = user_no
        executeTask(url_server!, requestParam) { (data, response, error) in
            let decoder = JSONDecoder()
            if error == nil {
                if data != nil {
                    //print("input: \(String(data: data!, encoding: .utf8)!)")
                    if let result = try? decoder.decode([Track].self, from: data!){
                        self.track = result
//                        DispatchQueue.main.async {
//
//                        }
                    }
                }
            }
        }
    }
    
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return track.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as! FavoriteTableViewCell
        let trackList = track[indexPath.row]
//        cell.trackTitleLabel.text =
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

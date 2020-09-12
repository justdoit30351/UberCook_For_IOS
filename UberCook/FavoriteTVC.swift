//
//  FavoriteTVC.swift
//  UberCook
//
//  Created by 超 on 2020/9/11.
//

import UIKit

class FavoriteTVC: UIViewController{

    @IBOutlet weak var trackSC: UIScrollView!
    @IBOutlet weak var trackSG: UISegmentedControl!
//    let userDefault = UserDefaults()
//    let url_server = URL(string: common_url + "UberCook_Servlet")
//    var track = [Track]()


    override func viewDidLoad() {
        super.viewDidLoad()
//        getTrack()
    }
    
//    func getTrack(){
//        let user_no = userDefault.value(forKey: "user_no")
//        var requestParam = [String: Any]()
//        requestParam["action"] = "getFollow"
//        requestParam["user_no"] = user_no
//        executeTask(url_server!, requestParam) { (data, response, error) in
//            let decoder = JSONDecoder()
//            if error == nil {
//                if data != nil {
//                    //print("input: \(String(data: data!, encoding: .utf8)!)")
//                    if let result = try? decoder.decode([Track].self, from: data!){
//                        self.track = result
////                        DispatchQueue.main.async {
////
////                        }
//                    }
//                }
//            }
//        }
//    }
    
    @IBAction func clickSegment(_ sender: UISegmentedControl) {
        let x = CGFloat(sender.selectedSegmentIndex) * trackSC.bounds.width
               let offset = CGPoint(x: x, y: 0)
        trackSC.setContentOffset(offset, animated: true)
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

extension FavoriteTVC: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        trackSG.selectedSegmentIndex = index
    }
}

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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
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

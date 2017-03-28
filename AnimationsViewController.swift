//
//  AnimationsViewController.swift
//  GATransitionAnimation
//
//  Created by houjianan on 2017/3/28.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

class AnimationsViewController: UITableViewController {

    enum vcType {
        case rain, sun, like
    }
    
    var data: [[String:Any]] = [["1" : "🌧", "2" : "RainAnimationViewController", "type" : vcType.rain],
                                ["1" : "🌞", "2" : "SunAnimationViewController", "type" : vcType.sun],
                                ["1" : "点赞", "2" : "LikeButtonViewController", "type" : vcType.like]]
                                
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "animationCell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]["1"] as! String?
        cell.detailTextLabel?.text = data[indexPath.row]["2"] as! String?
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = data[indexPath.row]["type"] as! vcType
        switch type {
        case .rain:
            self.navigationController?.pushViewController(RainAnimationViewController(), animated: true)
        case .sun:
            self.navigationController?.pushViewController(SunAnimationViewController(), animated: true)
        case .like:
            self.navigationController?.pushViewController(LikeButtonViewController(), animated: true)
        }
    }

}

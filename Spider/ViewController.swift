//
//  ViewController.swift
//  Spider
//
//  Created by 廣瀬雄大 on 2017/05/23.
//  Copyright © 2017年 廣瀬雄大. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let edge: CGFloat = 48
        let spiderButton = SpiderButton(
            image: #imageLiteral(resourceName: "add"),
            highlightedImage: nil,
            origin: CGPoint(x: UIScreen.main.bounds.midX - edge / 2,y: UIScreen.main.bounds.midY - edge / 2),
            edge: edge
            )!
        spiderButton.eventButtons = [
            SpiderEventButton(image: #imageLiteral(resourceName: "fb"), highlightedImage: nil, edge: edge)!,
            SpiderEventButton(image: #imageLiteral(resourceName: "gh"), highlightedImage: nil, edge: edge)!,
            SpiderEventButton(image: #imageLiteral(resourceName: "tw"), highlightedImage: nil, edge: edge)!,
            SpiderEventButton(image: #imageLiteral(resourceName: "in"), highlightedImage: nil, edge: edge)!,
            SpiderEventButton(image: #imageLiteral(resourceName: "insta"), highlightedImage: nil, edge: edge)!
            ]
        view.addSubview(spiderButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}


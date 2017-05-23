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
    }
    
    @IBAction func presentButtonPressed(_ sender: Any) {
        present(ModalViewController(), animated: true, completion: nil)
    }
    
    
    @IBAction func pushButtonPressed(_ sender: Any) {
        navigationController?.pushViewController(SecondViewController(), animated: true)
    }
    
}


class ModalViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        let button = UIButton(frame: CGRect(x: 100, y: 200, width: 200, height: 100))
        button.setTitle("close", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        view.addSubview(button)
    }
    
    func close() {
        dismiss(animated: true, completion: nil)
    }
}

class SecondViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .brown
    }
}

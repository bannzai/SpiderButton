//
//  SpiderWindow.swift
//  Spider
//
//  Created by 廣瀬雄大 on 2017/05/23.
//  Copyright © 2017年 廣瀬雄大. All rights reserved.
//

import UIKit
public class SpiderWindow: UIWindow {
    
    var spiderButton: SpiderButton!
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public init?(
        spiderButton: SpiderButton,
        frame: CGRect
        ) {
        
        self.spiderButton = spiderButton
        super.init(frame: frame)
        
        windowLevel = UIWindowLevelAlert - 1
        
        addSubview(spiderButton)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate let backgroundView: UIView = UIView(frame: .zero)
    fileprivate func configureBackgroundView() {
        insertSubview(backgroundView, belowSubview: spiderButton)
        
        backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        backgroundView.isHidden = state == .normal
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
    
}

//
//  SpiderWindow.swift
//  Spider
//
//  Created by 廣瀬雄大 on 2017/05/23.
//  Copyright © 2017年 廣瀬雄大. All rights reserved.
//

import UIKit

public enum SpiderButtonArrangementType {
    case expand
    case oneline
}

public enum SpiderButtonPositionMode {
    case fixed
    case variable
}

fileprivate enum SpiderButtonState {
    case normal
    case expand
}

public class SpiderWindow: UIWindow {
    
    let spiderButton: SpiderButton
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
        backgroundView.isHidden = state == .normal
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }

}

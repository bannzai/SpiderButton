//
//  SpiderEventButton.swift
//  Spider
//
//  Created by 廣瀬雄大 on 2017/05/23.
//  Copyright © 2017年 廣瀬雄大. All rights reserved.
//

import UIKit

protocol SpiderEventButtonDelegate {
    func eventButtonTapped(_ eventButton: SpiderEventButton)
}

public class SpiderEventButton: UIView {
    public typealias EventClosure = ((SpiderEventButton) -> Void)
    
    var delegate: SpiderEventButtonDelegate?
    var eventClosure: EventClosure?
    
    fileprivate let button: UIButton = UIButton(type: .custom)
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init?(
        image: UIImage,
        highlightedImage: UIImage?,
        edge: CGFloat,
        closure: EventClosure? = nil
        ) {
        let frame = CGRect(origin: .zero, size: CGSize(width: edge, height: edge))
        super.init(frame: frame)
        
        eventClosure = closure
        
        setup()
        configureButton(with: image, and: highlightedImage)
    }
    
    private func setup() {
        layer.cornerRadius = frame.size.width / 2
    }
    
    private func configureButton(with image: UIImage, and highlightedImage: UIImage?) {
        addSubview(button)
        
        button.frame = bounds
        button.setBackgroundImage(image, for: .normal)
        button.setBackgroundImage(highlightedImage, for: .highlighted)
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
    }
    
    func tapped() {
        print(#function)
        
        eventClosure?(self)
        delegate?.eventButtonTapped(self)
    }
}

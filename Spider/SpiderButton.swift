
//
//  SpiderButton.swift
//  Spider
//
//  Created by 廣瀬雄大 on 2017/05/23.
//  Copyright © 2017年 廣瀬雄大. All rights reserved.
//

import UIKit

public enum SpiderButtonState {
    case normal
    case expand
}


public class SpiderButton: UIView {
    
    public var eventButtons: [SpiderEventButton] = []
    
    fileprivate let button: UIButton = UIButton(type: .custom)
    fileprivate let backgroundView: UIView = UIView(frame: .zero)
    
    fileprivate var state: SpiderButtonState = .normal
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init?(
        image: UIImage,
        highlightedImage: UIImage?,
        center: CGPoint,
        edge: CGFloat
        ) {
        let frame = CGRect(origin: .zero, size: CGSize(width: edge, height: edge))
        super.init(frame: frame)
        
        self.center = center
        
        setupButton(
            with: image,
            and: highlightedImage
        )
        setupPanGesture()
        setupBackgroundView()
    }
    
    private func setupButton(
        with image: UIImage,
        and highlightedImage: UIImage?
        ) {
        addSubview(button)
        
        button.frame = bounds
        button.setBackgroundImage(image, for: .normal)
        button.setBackgroundImage(highlightedImage, for: .highlighted)
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
    }
    
    fileprivate func setupBackgroundView() {
        addSubview(backgroundView)
        sendSubview(toBack: backgroundView)
        
        backgroundView.layer.cornerRadius = 8
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
    
    func convertPosition() -> CGPoint {
        switch state {
        case .normal:
            fatalError()
        case .expand:
            fatalError()
        }
    }
    func tapped() {
        switch state {
        case .normal:
            expand()
        case .expand:
            close()
        }
    }
    
    fileprivate func expand() {
        state = .expand
        
        eventButtons
            .enumerated()
            .forEach { index, eventButton in
            backgroundView.addSubview(eventButton)
            eventButton.delegate = self
        }
        
        do { // configure self and button frame
            let center = self.center
            
            // expand self
            frame = superview!.bounds
            
            // keep button position
            button.center = center
            
            // backgroundView center equal button
            backgroundView.center = button.center
            backgroundView.frame.size = .zero
        }
        
        UIView.animate(
            withDuration: 1,
            animations:{
                let edge: CGFloat = UIScreen.main.bounds.width * 0.8
                self.backgroundView.frame.size = CGSize(width: edge, height: edge)
                self.backgroundView.center = self.center
        })
        
    }
    
    fileprivate func close() {
        state = .normal
        
        eventButtons.forEach {
            $0.transform = CGAffineTransform.identity
            $0.removeFromSuperview()
        }
        
        do { // configure self and button frame
            // shrink self to button position
            frame = button.frame
            
            // keep button position and size
            button.frame = bounds
        }
    }
    
    private func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panned(_:)))
        addGestureRecognizer(panGesture)
    }
    
    func panned(_ gesture: UIPanGestureRecognizer) {
        guard state == .normal else {
            return
        }
        
        let location = gesture.location(in: superview)
        center = location
        
        switch gesture.state {
        case .began:
            print("began")
        case .ended:
            moveToScreenEdge(from: location)
        default:
            print("other: \(gesture.state.rawValue)")
        }
    }
    
    private func moveToScreenEdge(from location: CGPoint) {
        guard let superview = superview else {
            fatalError("superview not found")
        }
        
        let superviewSize = superview.bounds.size
        let moveForYDistance = superviewSize.height * CGFloat(0.10)
        
        let touchBorderAdjustMargin: CGFloat = 10
        let destinationLocation: CGPoint
        if location.y < moveForYDistance {
            destinationLocation = CGPoint(x: location.x, y: bounds.width / 2 + touchBorderAdjustMargin)
        } else if location.y > superviewSize.height - moveForYDistance {
            destinationLocation = CGPoint(x: location.x, y: superviewSize.height - bounds.height / 2 - touchBorderAdjustMargin)
        } else if location.x > superviewSize.width / 2 {
            destinationLocation = CGPoint(x: superviewSize.width - (bounds.width / 2 + touchBorderAdjustMargin), y: location.y)
        } else {
            destinationLocation = CGPoint(x: bounds.width / 2 + touchBorderAdjustMargin, y: location.y)
        }
        
        let touchBorderAnimation = CABasicAnimation(keyPath: "position")
        touchBorderAnimation.delegate = self
        touchBorderAnimation.isRemovedOnCompletion = false
        touchBorderAnimation.fromValue = location as AnyObject
        touchBorderAnimation.toValue = destinationLocation as AnyObject
        touchBorderAnimation.duration = 0.3
        touchBorderAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        layer.add(touchBorderAnimation, forKey: "touchBorder")
        
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        center = destinationLocation
        CATransaction.commit()
    }
}

extension SpiderButton: CAAnimationDelegate {
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
    }
}

// MARK: - SpiderEventButtonDelegate
extension SpiderButton: SpiderEventButtonDelegate {
    func eventButtonTapped(_ eventButton: SpiderEventButton) {
        close()
    }
}

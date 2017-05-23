//
//  SpiderButton.swift
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

public class SpiderButton: UIView {
    
    public var eventButtons: [SpiderEventButton] = []
    public var position: SpiderButtonPositionMode = .fixed
    public var arrangementType: SpiderButtonArrangementType = .expand
    
    fileprivate let button: UIButton = UIButton(type: .custom)
    fileprivate let backgroundView: UIView = UIView(frame: .zero)
    
    fileprivate var state: SpiderButtonState = .normal
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    public convenience init?(image: UIImage, origin: CGPoint, edge: Float) {
//        self.init(image: image, origin, origin, edge: CGFloat(edge))
//    }
    
    public init?(
        image: UIImage,
        highlightedImage: UIImage?,
        origin: CGPoint,
        edge: CGFloat
        ) {
        let frame = CGRect(origin: origin, size: CGSize(width: edge, height: edge))
        super.init(frame: frame)
        
        setup()
        configureButton(
            with: image,
            and: highlightedImage,
            frame: CGRect(origin: origin, size: CGSize(width: edge, height: edge))
        )
        configureBackgroundView()
    }
    
    private func setup() {
        layer.cornerRadius = frame.size.width / 2
    }
    
    private func configureButton(
        with image: UIImage,
        and highlightedImage: UIImage?,
        frame: CGRect
        ) {
        addSubview(button)
        
        button.frame = bounds
        button.setBackgroundImage(image, for: .normal)
        button.setBackgroundImage(highlightedImage, for: .highlighted)
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
    }
    
    fileprivate func configureBackgroundView() {
        insertSubview(backgroundView, belowSubview: button)
        
        backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundView.isHidden = state == .normal
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
        print(#function)
        
        frame = backgroundView.bounds
        configureBackgroundView()
        
        switch state {
        case .normal:
            expand(with: arrangementType)
        case .expand:
            close()
        }
    }
    
    fileprivate func expand(with arrangementType: SpiderButtonArrangementType) {
        switch arrangementType {
        case .expand:
            eventButtons.enumerated().forEach { index, button in
                backgroundView.addSubview(button)
                
                button.frame = bounds
                button.transform = CGAffineTransform(translationX: -100, y: 100 * CGFloat(index))
                
                button.delegate = self
            }
        case .oneline:
            fatalError()
        }
        
        state = .expand
    }
    
    private func configurePanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panned(_:)))
        addGestureRecognizer(panGesture)
    }
    
    func panned(_ gesture: UIPanGestureRecognizer) {
        print(#function)
    }
    
    fileprivate func close() {
        eventButtons.forEach {
            $0.transform = CGAffineTransform.identity
            $0.removeFromSuperview()
        }
        
        state = .normal
        configureBackgroundView()
    }
}

// MARK: - override
extension SpiderButton {
    public override func willMove(toWindow newWindow: UIWindow?) {
        guard let newWindow = newWindow else {
            return
        }
        
        backgroundView.frame = newWindow.bounds
    }
    
    public override func willMove(toSuperview newSuperview: UIView?) {
        guard let window = superview?.window else {
            return
        }
        
        backgroundView.frame = window.bounds
    }
}


extension SpiderButton: SpiderEventButtonDelegate {
    func eventButtonTapped(_ eventButton: SpiderEventButton) {
        close()
    }
}

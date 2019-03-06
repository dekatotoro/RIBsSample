//
//  LoadingView.swift
//  RIBsSample
//
//  Created by Yuji Hato on 2019/03/05.
//  Copyright © 2019年 dekatotoro. All rights reserved.
//

import UIKit
import SpringIndicator

private let LaodingIndicatorSize: CGFloat = 32

class LoadingView: UIView {
    
    enum LoadingType {
        case fullScreen, fullGuard, point
    }
    
    fileprivate(set) var loadingType: LoadingType = .point
    
    let indicator = SpringIndicator(frame: CGRect(x: 0, y: 0, width: LaodingIndicatorSize, height: LaodingIndicatorSize))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    func initialize() {
        indicator.lineColor = UIColor.gray
        indicator.lineWidth = 3
        indicator.lineCap = true
        indicator.rotationDuration = 1.2
        addSubview(indicator)
        isHidden = true
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return loadingType == .fullGuard
    }
    
    @discardableResult
    func setType(_ loadingType: LoadingType) -> LoadingView {
        self.loadingType = loadingType
        backgroundColor = (loadingType == .fullGuard) ? UIColor.black.withAlphaComponent(0.5) : .clear
        
        let isFullScreen = (loadingType == .fullScreen || loadingType == .fullGuard)
        indicator.lineColor = isFullScreen ? UIColor.white : UIColor.gray
        indicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            indicator.widthAnchor.constraint(equalToConstant: LaodingIndicatorSize),
            indicator.heightAnchor.constraint(equalToConstant: LaodingIndicatorSize)
            ])

        if isFullScreen {
            let margin: CGFloat = -24
            NSLayoutConstraint.activate([
                indicator.bottomAnchor.constraint(equalTo: bottomAnchor, constant: margin),
                indicator.rightAnchor.constraint(equalTo: rightAnchor, constant: margin)
                ])
        } else {
            NSLayoutConstraint.activate([
                indicator.centerXAnchor.constraint(equalTo: centerXAnchor),
                indicator.centerYAnchor.constraint(equalTo: centerYAnchor)
                ])
        }
        return self
    }
    
    func hidden(_ hidden: Bool) {
        self.isHidden = hidden
        
        if hidden {
            indicator.stop(with: false, completion: nil)
        } else {
            indicator.start()
        }
    }
}

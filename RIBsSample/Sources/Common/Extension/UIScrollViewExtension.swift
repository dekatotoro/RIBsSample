//
//  UIScrollViewExtension.swift
//  RIBsSample
//
//  Created by Yuji Hato on 2019/03/05.
//  Copyright © 2019年 dekatotoro. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

extension AppExtension where Base: UIScrollView {

    var scrolledToBottomEnd: ControlEvent<Void> {
        let source = base.rx.contentOffset
            .filter { [weak base] contentOffset in
                guard let base = base else { return false }
                let visibleHeight = base.frame.height - base.contentInset.top - base.contentInset.bottom
                let y = contentOffset.y + base.contentInset.top
                let threshold = max(0.0, base.contentSize.height - visibleHeight)
                return y >= threshold
            }
            .distinctUntilChanged()
            .map(void)
        return ControlEvent(events: source)
    }
}


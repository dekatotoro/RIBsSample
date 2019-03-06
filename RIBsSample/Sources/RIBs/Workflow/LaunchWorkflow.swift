//
//  LaunchWorkflow.swift
//  RIBsSample
//
//  Created by Yuji Hato on 2019/03/05.
//  Copyright © 2019年 Yuji Hato. All rights reserved.
//

import Foundation
import RIBs
import RxSwift


public protocol RootActionableItem: class {
    func waitForXXXX() -> Observable<(SearchActionableItem, ())>
}

public protocol SearchActionableItem: class {
    func launch(query: String) -> Observable<(SearchActionableItem, ())>
}

public class LaunchWorkflow: Workflow<RootActionableItem> {
    
    public init(url: URL) {
        super.init()
        
        self
            .onStep { (rootItem: RootActionableItem) -> Observable<(SearchActionableItem, ())> in
                rootItem.waitForXXXX()
            }
            .onStep { searchActionableItem, _ -> Observable<(SearchActionableItem, ())> in
                searchActionableItem.launch(query: "")
            }
            .commit()
    }
}

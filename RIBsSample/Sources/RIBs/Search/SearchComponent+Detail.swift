//
//  SearchComponent+Detail.swift
//  RIBsSample
//
//  Created by Yuji Hato on 2019/03/06.
//  Copyright © 2019 Yuji Hato. All rights reserved.
//

import RIBs

/// The dependencies needed from the parent scope of Search to provide for the Detail scope.
// TODO: Update SearchDependency protocol to inherit this protocol.
protocol SearchDependencyDetail: Dependency {
    // TODO: Declare dependencies needed from the parent scope of Search to provide dependencies
    // for the Detail scope.
}

extension SearchComponent: DetailDependency {

    // TODO: Implement properties to provide for Detail scope.
}

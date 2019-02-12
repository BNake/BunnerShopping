//
//  TrademarkProductConfigurator.swift
//  BunnerShopping
//
//  Created Tuan Anh on 2/8/19.
//  Copyright © 2019 Savvycom. All rights reserved.
//
//  Template generated by Savvycom
//

import UIKit

class TrademarkProductConfigurator {
    
    // MARK: Configuration
    class func viewcontroller() -> TrademarkProductViewController {
//        let viewController = TrademarkProductViewController(nibName: "TrademarkProductViewController", bundle: nil)
        let viewController = TrademarkProductViewController(itemInfo: "FOLLOWING")

        
        let presenter = TrademarkProductPresenter()
        presenter.output = viewController
        
        let interactor = TrademarkProductInteractor()
        interactor.output = presenter
        
        let router = TrademarkProductRouter()
        router.viewController = viewController

//        //Data passing
//        router.dataSource = interactor
        
        viewController.output = interactor
        viewController.router = router
        
        return viewController
    }
}

//// MARK: Data passing
//protocol TrademarkProductViewControllerDataSource: class {
//    //Must be a struct model
//    var dataPassing: AnyObject? {
//        get set
//    }
//}

// MARK: View Interface
protocol TrademarkProductViewControllerOutputProtocol {

}

// MARK: Interactor Interface
protocol TrademarkProductInteractorOutputProtocol {

}

// MARK: Presenter Interface
protocol TrademarkProductPresenterOutputProtocol: class {
    
}

// MARK: Router
protocol TrademarkProductRouterProtocol {

}

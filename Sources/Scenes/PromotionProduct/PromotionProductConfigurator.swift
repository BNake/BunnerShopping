//
//  PromotionProductConfigurator.swift
//  BunnerShopping
//
//  Created Tuan Anh on 2/8/19.
//  Copyright © 2019 Savvycom. All rights reserved.
//
//  Template generated by Savvycom
//

import UIKit

class PromotionProductConfigurator {
    
    // MARK: Configuration
    class func viewcontroller() -> PromotionProductViewController {
//        let viewController = PromotionProductViewController(nibName: "PromotionProductViewController", bundle: nil)
        let viewController = PromotionProductViewController(itemInfo: "FOLLOWING")

        
        let presenter = PromotionProductPresenter()
        presenter.output = viewController
        
        let interactor = PromotionProductInteractor()
        interactor.output = presenter
        
        let router = PromotionProductRouter()
        router.viewController = viewController

//        //Data passing
//        router.dataSource = interactor
        
        viewController.output = interactor
        viewController.router = router
        
        return viewController
    }
}

//// MARK: Data passing
//protocol PromotionProductViewControllerDataSource: class {
//    //Must be a struct model
//    var dataPassing: AnyObject? {
//        get set
//    }
//}

// MARK: View Interface
protocol PromotionProductViewControllerOutputProtocol {

}

// MARK: Interactor Interface
protocol PromotionProductInteractorOutputProtocol {

}

// MARK: Presenter Interface
protocol PromotionProductPresenterOutputProtocol: class {
    
}

// MARK: Router
protocol PromotionProductRouterProtocol {

}

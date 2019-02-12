//
//  MakeUpProductConfigurator.swift
//  BunnerShopping
//
//  Created Tuan Anh on 2/8/19.
//  Copyright © 2019 Savvycom. All rights reserved.
//
//  Template generated by Savvycom
//

import UIKit

class MakeUpProductConfigurator {
    
    // MARK: Configuration
    class func viewcontroller() -> MakeUpProductViewController {
//        let viewController = MakeUpProductViewController(nibName: "MakeUpProductViewController", bundle: nil)
        let viewController = MakeUpProductViewController(itemInfo: "FOLLOWING")

        
        let presenter = MakeUpProductPresenter()
        presenter.output = viewController
        
        let interactor = MakeUpProductInteractor()
        interactor.output = presenter
        
        let router = MakeUpProductRouter()
        router.viewController = viewController

//        //Data passing
//        router.dataSource = interactor
        
        viewController.output = interactor
        viewController.router = router
        
        return viewController
    }
}

//// MARK: Data passing
//protocol MakeUpProductViewControllerDataSource: class {
//    //Must be a struct model
//    var dataPassing: AnyObject? {
//        get set
//    }
//}

// MARK: View Interface
protocol MakeUpProductViewControllerOutputProtocol {

}

// MARK: Interactor Interface
protocol MakeUpProductInteractorOutputProtocol {

}

// MARK: Presenter Interface
protocol MakeUpProductPresenterOutputProtocol: class {
    
}

// MARK: Router
protocol MakeUpProductRouterProtocol {

}

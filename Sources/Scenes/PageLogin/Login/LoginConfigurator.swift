//
//  LoginConfigurator.swift
//  VIPTemplate
//
//  Created Nguyen Chi Hieu on 6/15/18.
//  Copyright © 2018 Savvycom. All rights reserved.
//
//  Template generated by Savvycom
//

import UIKit

class LoginConfigurator {
    
    // MARK: Configuration
    class func viewcontroller() -> LoginViewController {
//        let viewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
        
        let viewController = LoginViewController(itemInfo: "FOLLOWING")
        
        let presenter = LoginPresenter()
        presenter.output = viewController
        
        let interactor = LoginInteractor()
        interactor.output = presenter
        
        let router = LoginRouter()
        router.viewController = viewController

        viewController.output = interactor
        viewController.router = router
        
        return viewController
    }
}

// MARK: View Interface
protocol LoginViewControllerProtocol {

}

// MARK: Interactor Interface
protocol LoginInteractorProtocol {

}

// MARK: Presenter Interface
protocol LoginPresenterProtocol: class {
    
}

// MARK: Router
protocol LoginRouterProtocol {

}

//
//  FashionProductViewController.swift
//  BunnerShopping
//
//  Created Tuan Anh on 2/8/19.
//  Copyright © 2019 Savvycom. All rights reserved.
//
//  Template generated by Savvycom
//

import UIKit

// MARK: View
class FashionProductViewController: UIViewController {
    //swiftlint:disable all
    var output: FashionProductViewControllerOutputProtocol!
    var router: FashionProductRouter!
    //swiftlint:enable all
    var viewModel: FashionProductModel.ViewModel?
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataOnLoad()
    }
    
    // MARK: Fetch FashionProduct
    private func fetchDataOnLoad() {
        // NOTE: Ask the Interactor to do some work
        
    }
   
}

// MARK: Connect View, Interactor, and Presenter
extension FashionProductViewController: FashionProductPresenterOutputProtocol {
    
}

//
//  PromotionProductViewController.swift
//  BunnerShopping
//
//  Created Tuan Anh on 2/8/19.
//  Copyright © 2019 Savvycom. All rights reserved.
//
//  Template generated by Savvycom
//

import UIKit
import XLPagerTabStrip

// MARK: View
class PromotionProductViewController: UIViewController, IndicatorInfoProvider {
    //swiftlint:disable all
    var output: PromotionProductViewControllerOutputProtocol!
    var router: PromotionProductRouter!
    //swiftlint:enable all
    var viewModel: PromotionProductModel.ViewModel?
    var itemInfo: IndicatorInfo = "View"
    
    init(itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
        super.init(nibName: "PromotionProductViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataOnLoad()
    }
    
    // MARK: Fetch PromotionProduct
    private func fetchDataOnLoad() {
        // NOTE: Ask the Interactor to do some work
        
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
   
}

// MARK: Connect View, Interactor, and Presenter
extension PromotionProductViewController: PromotionProductPresenterOutputProtocol {
    
}
//
//  TrademarkProductViewController.swift
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
class TrademarkProductViewController: UIViewController, IndicatorInfoProvider {
    //swiftlint:disable all
    var output: TrademarkProductViewControllerOutputProtocol!
    var router: TrademarkProductRouter!
    //swiftlint:enable all
    var viewModel: TrademarkProductModel.ViewModel?
    var itemInfo: IndicatorInfo = "View"
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataOnLoad()
    }
    
    init(itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
        super.init(nibName: "TrademarkProductViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Fetch TrademarkProduct
    private func fetchDataOnLoad() {
        // NOTE: Ask the Interactor to do some work
        
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
   
}

// MARK: Connect View, Interactor, and Presenter
extension TrademarkProductViewController: TrademarkProductPresenterOutputProtocol {
    
}

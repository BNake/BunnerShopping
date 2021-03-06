//
//  PageTabHomeViewController.swift
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
class PageTabHomeViewController: ButtonBarPagerTabStripViewController {
    //swiftlint:disable all
    var output: PageTabHomeViewControllerOutputProtocol!
    var router: PageTabHomeRouter!
    //swiftlint:enable all
    var viewModel: PageTabHomeModel.ViewModel?
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataOnLoad()
    }
    
    // MARK: Fetch PageTabHome
    private func fetchDataOnLoad() {
        // NOTE: Ask the Interactor to do some work
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = .orange
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child1 = FeaturedProductViewController(itemInfo: "Nổi bật")
        let child2 = PromotionProductViewController(itemInfo: "Chương trình khuyến mãi")
        let child3 = ElectronicProductViewController(itemInfo: "Điện tử")
        let child4 = HomeAndLifeProductViewController(itemInfo: "Nhà cửa và đời sống")
        let child5 = MunAndBabyProductViewController(itemInfo: "Mẹ và bé")
        let child6 = MakeUpProductViewController(itemInfo: "Làm đẹp")
        let child7 = SportAndTourProductViewController(itemInfo: "Thể thao & Du lịch")
        let child8 = TrademarkProductViewController(itemInfo: "Thương hiệu")
        return [child1, child2, child3, child4, child5, child6, child7, child8]
    }
   
}

// MARK: Connect View, Interactor, and Presenter
extension PageTabHomeViewController: PageTabHomePresenterOutputProtocol {
    
}

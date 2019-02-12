//
//  LoginViewController.swift
//  VIPTemplate
//
//  Created Nguyen Chi Hieu on 6/15/18.
//  Copyright © 2018 Savvycom. All rights reserved.
//
//  Template generated by Savvycom
//

import UIKit
import SkyFloatingLabelTextField
import XLPagerTabStrip

// MARK: View
class LoginViewController: UIViewController, IndicatorInfoProvider {
    
    var itemInfo: IndicatorInfo = "View"
    
    //swiftlint:disable all
    var output: LoginViewControllerProtocol!
    var router: LoginRouter!
    //swiftlint:enable all
    var viewModel: LoginModel.ViewModel?
    @IBOutlet weak var passwordTF: SkyFloatingLabelTextField!
    
    init(itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
        super.init(nibName: "LoginViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataOnLoad()
        
    }
    
    @IBAction func refresh(_ sender: Any) {
        
    }
    
    // MARK: Fetch Login
    private func fetchDataOnLoad() {
        // NOTE: Ask the Interactor to do some work
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "ic_visibility"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(passwordTF.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.refresh), for: .touchUpInside)
        passwordTF.rightView = button
        passwordTF.rightViewMode = .always
        
        passwordTF.rightView = button
        passwordTF.rightViewMode = .unlessEditing
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
   
}

// MARK: Connect View, Interactor, and Presenter
extension LoginViewController: LoginPresenterProtocol {
    
}

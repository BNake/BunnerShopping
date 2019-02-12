//
//  SmallLevelView.swift
//  VIPTemplate
//
//  Created by The Son    on 10/31/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import UIKit

class SmallLevelView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet weak var liveNumberLabel : UILabel!
    @IBOutlet weak var liveLbel : UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let nibView = Bundle.main.loadNibNamed("SmallLevelView", owner: self, options: nil)?.first as! UIView
        nibView.frame = self.bounds
        nibView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        self.addSubview(nibView)
        
        self.setupStyle()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let nibView = Bundle.main.loadNibNamed("SmallLevelView", owner: self, options: nil)?.first as! UIView
        nibView.frame = self.bounds
        nibView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        self.addSubview(nibView)
        
        self.setupStyle()
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
    }
    
    fileprivate func setupStyle() {
        self.backgroundColor = UIColor.heloTangerine
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.layer.frame.height/2
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.heloBrownyOrange.cgColor
        
        self.liveNumberLabel.layer.masksToBounds = true
        self.liveNumberLabel.layer.cornerRadius = self.liveNumberLabel.layer.frame.height/2
        self.liveNumberLabel.backgroundColor = UIColor.heloBrownyOrange
    }

}

//
//  nibTest.swift
//  QuotePro
//
//  Created by Kyla  on 2018-09-12.
//  Copyright © 2018 Kyla . All rights reserved.
//

import UIKit

class nibTest: UIView {


  @IBOutlet var contentView: UIView!
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupWithQuote()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupWithQuote()
  }
  
  private func setupWithQuote() {
    Bundle.main.loadNibNamed("nibTest", owner: self, options: nil)
    addSubview(contentView)
    contentView.frame = self.bounds
    contentView.autoresizingMask = [ .flexibleHeight, .flexibleWidth]
  }
  
}

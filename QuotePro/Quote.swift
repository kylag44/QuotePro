//
//  Quote.swift
//  QuotePro
//
//  Created by Kyla  on 2018-09-12.
//  Copyright © 2018 Kyla . All rights reserved.
//

import UIKit

class Quote: NSObject {
  
  var name: String
  var quote: String
  
  init?(name: String, quote: String) {
    self.name = name
    self.quote = quote
  }
}


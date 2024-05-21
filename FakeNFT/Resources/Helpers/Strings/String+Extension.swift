//
//  String+Extension.swift
//  FakeNFT
//
//  Created by Леонид Турко on 05.04.2024.
//

import Foundation

extension String {
  var urlEncoder: String {
    return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
  }
  
  var urlDecoder: String? {
    return self.removingPercentEncoding!
  }
}

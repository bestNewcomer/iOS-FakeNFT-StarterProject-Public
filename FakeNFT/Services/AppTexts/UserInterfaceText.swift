//
//  UserInterfaceText.swift
//  FakeNFT
//
//  Created by Леонид Турко on 05.04.2024.
//

import Foundation

struct AppStrings {
  struct CatalogVC {
    static var sorting: String {
      return NSLocalizedString("catalogSorting", comment: "")
    }
    static var sortByName: String {
      return NSLocalizedString("catalogSortByName", comment: "")
    }
    static var sortByNFTCount: String {
      return NSLocalizedString("catalogSortByNFTCount", comment: "")
    }
    static var close: String {
      return NSLocalizedString("catalogClose", comment: "")
    }
  }
  
  struct CollectionVC {
    static var authorInfo: String {
      return NSLocalizedString("AboutAuthor", comment: "")
    }
  }
}

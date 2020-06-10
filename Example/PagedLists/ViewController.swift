//
//  ViewController.swift
//  PagedLists
//
//  Created by German Lopez on 06/10/2020.
//  Copyright (c) 2020 German Lopez. All rights reserved.
//

import UIKit
import PagedLists

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Testing correct visibility of variables and methods
    
    let tableView = PagedTableView(frame: .zero)
    tableView.elementsPerPage = 20
    tableView.direction = .atBottom
    tableView.hasMore = false
    print(tableView.currentPage)
    
    let collection = PagedCollectionView(frame: .zero)
    collection.elementsPerPage = 20
    collection.hasMore = false
    print(collection.currentPage)
  }
}


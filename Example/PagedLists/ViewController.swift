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
  
  /// Typically your data source count
  private var totalTableRows = 20
  private var totalCollectionItems = 10
  
  let collectionCellHeight: CGFloat = 50
  let collectionMargins: CGFloat = 4
  
  lazy var tableView = PagedTableView(frame: .zero)
  lazy var collectionView = PagedCollectionView(frame: .zero)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupLayout()
    configureTableView()
    configureCollectionView()
  }
  
  func configureTableView() {
    tableView.elementsPerPage = 20
    tableView.updateDelegate = self
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableCell")
  }
  
  func configureCollectionView() {
    collectionView.elementsPerPage = 10
    collectionView.updateDelegate = self
    collectionView.dataSource = self
    if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
      layout.itemSize = CGSize(width: collectionCellHeight, height: collectionCellHeight)
      layout.minimumInteritemSpacing = collectionMargins
      layout.scrollDirection = .horizontal
    }
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CollectionCell")
    
    collectionView.backgroundColor = .lightGray
    collectionView.contentInset = UIEdgeInsets(
      top: collectionMargins,
      left: collectionMargins,
      bottom: collectionMargins,
      right: collectionMargins
    )
  }
  
  func setupLayout() {
    tableView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(tableView)
    NSLayoutConstraint.activate([
      bottomLayoutGuide.topAnchor.constraint(equalTo: tableView.bottomAnchor),
      view.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
      view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor)
    ])
    
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(collectionView)
    NSLayoutConstraint.activate([
      topLayoutGuide.bottomAnchor.constraint(equalTo: collectionView.topAnchor),
      view.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
      view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
      collectionView.heightAnchor.constraint(equalToConstant:
        collectionCellHeight + collectionMargins * 2
      ),
      collectionView.bottomAnchor.constraint(equalTo: tableView.topAnchor)
    ])
  }
}

// MARK: Pagination Delegates

extension ViewController: PagedTableViewDelegate {
  func loadTableData(page: Int, completion: (Int, NSError?) -> Void) {
    totalTableRows += tableView.elementsPerPage
    completion(tableView.elementsPerPage, nil)
    tableView.reloadData()
  }
}

extension ViewController: PagedCollectionViewDelegate {
  func loadCollectionData(page: Int, completion: (Int, NSError?) -> Void) {
    totalCollectionItems += collectionView.elementsPerPage
    completion(collectionView.elementsPerPage, nil)
    collectionView.reloadData()
  }
}

// Note: If you override the delegate for your PagedTableView or PagedCollectionView like:
// tableView.delegate = <UITableViewDelegate conformant object>
// you need to forward the scrolling events to automatically load new pages if needed.
// See the code below on how to do this.
/*
  extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
      if scrollView === tableView {
        tableView.scrollViewDidScroll(tableView)
      } else {
        collectionView.scrollViewDidScroll(collectionView)
      }
    }
  }
 */

// MARK: UITableView & UICollectionView Data Sources

extension ViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return totalTableRows
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
    cell.textLabel?.text = "Row #\(indexPath.row)"
    return cell
  }
}

extension ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return totalCollectionItems
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: "CollectionCell",
      for: indexPath
    )
    let titleLabel = cell.contentView.subviews.first as? UILabel ?? UILabel(frame: cell.bounds)
    cell.contentView.addSubview(titleLabel)
    titleLabel.textAlignment = .center
    
    titleLabel.text = "\(indexPath.item)"
    
    cell.backgroundColor = .white
    cell.layer.cornerRadius = collectionMargins
    return cell
  }
}

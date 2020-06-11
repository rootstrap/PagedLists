//
//  PagedCollectionView.swift
//  PagedLists
//
//  Created by German Lopez on 3/22/16.
//  Copyright © 2020 Rootstrap Inc. All rights reserved.
//
import Foundation

#if canImport(UIKit)
import UIKit

public protocol PagedCollectionViewDelegate: class {
  // Required - Should not call this method directly or you will need to take care of
  // page update and flags status. Call loadContentIfNeeded instead
  func collectionView(
    _ collectionView: PagedCollectionView,
    needsDataForPage page: Int,
    completion: (_ elementsAdded: Int, _ error: NSError?) -> Void
  )
}

open class PagedCollectionView: UICollectionView {
  
  public private(set) var currentPage = 1
  public private(set) var isLoading = false
  //  This will be handled automatically taking into account newElements of updateDelegate completion
  //  call and elementsPerPage. If your uploadDelegate provides pagination data, you can take control
  //  over this flag to avoid unnecesary calls to your delegate.
  public var hasMore = true
  public var elementsPerPage = 10
  // Responsible for loading the content and call the completion with newElements count.
  public weak var updateDelegate: PagedCollectionViewDelegate!
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: frame, collectionViewLayout: layout)
    commonInit()
  }
  
  public init(frame: CGRect) {
    super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
    commonInit()
  }
  
  private func commonInit() {
    delegate = self
  }
  
  public func loadContentIfNeeded() {
    guard hasMore && !isLoading else {
      return
    }
    isLoading = true
    updateDelegate.collectionView(
      self,
      needsDataForPage: currentPage,
      completion: { (newElements, error) in
        self.isLoading = false
        guard error == nil else {
          return
        }
        self.currentPage += 1
        self.hasMore = newElements == self.elementsPerPage
    })
  }
  
  public func reset() {
    currentPage = 1
    hasMore = true
    isLoading = false
  }
  
  //MARK: Normal Scroll
  
  func didScrollBeyondTop() -> Bool {
    return contentOffset.y < 0
  }
  
  func didScrollBeyondBottom() -> Bool {
    return contentOffset.y >= (contentSize.height - bounds.size.height)
  }
  
  func didScrollBeyondLeft() -> Bool {
    return contentOffset.x < 0
  }
  
  func didScrollBeyondRight() -> Bool {
    return contentOffset.x >= (contentSize.width - bounds.size.width)
  }
  
  //MARK: Paged Scroll
  
  func didReachLastVerticalPage() -> Bool {
    return contentOffset.y >= (contentSize.height / frame.size.height - 1) * frame.size.height
  }
  
  func didReachLastHorizontalPage() -> Bool {
    return contentOffset.x >= (contentSize.width / frame.size.width - 1) * frame.size.width
  }
  
  //New page should be loaded when:
  // 1 - CollectionView scrolling vertically:
  //    - pagingEnabled property on AND collectionView reach minimum content offset of the last vertical page
  // OR
  //    - pagingEnabled property off AND collectionView scroll reaches offset beyond last vertical page
  // 2 - CollectionView scrolling horizontally:
  //    - pagingEnabled property on AND collectionView reach minimum content offset of the last horizontal page
  // OR
  //    - pagingEnabled property off AND collectionView scroll reaches offset beyond last horizontal page
  func shouldLoadNewContent() -> Bool {
    guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
      return false
    }
    return layout.scrollDirection == .vertical ?
      (isPagingEnabled && didReachLastVerticalPage()) || (!isPagingEnabled && didScrollBeyondBottom()) :
      (isPagingEnabled && didReachLastHorizontalPage()) || (!isPagingEnabled && didScrollBeyondRight())
  }
}

extension PagedCollectionView: UICollectionViewDelegate, UIScrollViewDelegate {
  
  public func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if shouldLoadNewContent() {
      loadContentIfNeeded()
    }
  }
}

#endif

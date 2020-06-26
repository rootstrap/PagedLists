<p align="center">
<img src="https://github.com/rootstrap/PagedLists/blob/master/paged-lists-logo.png" width="200"/>
<br/>
</p>

# PagedLists

[![CI Status](https://img.shields.io/travis/rootstrap/PagedLists.svg?style=flat)](https://travis-ci.org/rootstrap/PagedLists)
[![Version](https://img.shields.io/cocoapods/v/PagedLists.svg?style=flat)](https://cocoapods.org/pods/PagedLists)
[![License](https://img.shields.io/cocoapods/l/PagedLists.svg?style=flat)](https://cocoapods.org/pods/PagedLists)
[![Platform](https://img.shields.io/cocoapods/p/PagedLists.svg?style=flat)](https://cocoapods.org/pods/PagedLists)
[![Carthage](https://img.shields.io/badge/Carthage-compatible-success)](#installation)
[![SPM](https://img.shields.io/badge/SPM-compatible-success)](#installation)
[![Swift Version](https://img.shields.io/badge/Swift%20Version-5.2-orange)](https://cocoapods.org/pods/PagedLists)

## What is it?

**PagedLists** gives you custom `UITableView` and `UICollectionView` classes that supports pagination.
All the logic and tracking of loading states, current page and when to actually request next pages is handled by these components.

#### Features:
- Customizable number of elements per page.
- Multiple scrolling directions are supported(i.e: You can load new pages of messages at the top of a chat.)
- Supports paged scrolling in `UICollectionView`.
- Uses delegation to load content from your desired source.

## Installation

#### 1. Cocoapods

**PagedLists** is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:


```ruby

pod 'PagedLists', '~> 1.0.0'

```

#### 2. Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.
Add the following line to your `Cartfile` and follow the [installation instructions](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application).

```
github "rootstrap/PagedLists" ~> 1.0.0
```

#### 3. Swift Package Manager

- In XCode 11, go to File -> Swift Packages -> Add Package Dependency.
- Enter the repo URL(https://github.com/rootstrap/PagedLists) and click Next.
- Select the version rule desired(you can specify a version number, branch or commit) and click Next. This library supports SPM starting from the version 1.0.0.
- Finally, select the target where you want to use the framework.

That should be it. **PagedLists** should appear in the navigation panel as a dependency and the framework will be linked automatically to your target.


**Note:** It is always recommended to lock your external libraries to a specific version.

## Usage

You can add a `PagedTableView` or `PagedCollectionView` programmatically or via Storyboards by specifying the class in the attributes inspector.

```swift
let tableView = PagedTableView(frame: <some CGRect>)
```

#### Configuration

Set the number of elements per page you are expecting from your data source.

```swift
tableView.elementsPerPage = 20
```

#### The pagination delegate

```swift
tableView.updateDelegate = self
```

By conforming to the pagination protocol, `PagedTableView` and `PagedCollectionView` gives you an opportunity to load the data from your desired source. You must then send the element count back or the error in case of failure.


```swift
extension ViewController: PagedTableViewDelegate {

  func tableView(
    _ tableView: PagedTableView,
    needsDataForPage page: Int,
    completion: (Int, NSError?) -> Void
  ) {
    // Load data from a network request and communicate results
    // back to the PagedTableView
    viewModel.getItems(
      page: page,
      success: { [weak self] newItemsCount in
        tableView.reloadData()
        completion(newItemsCount, nil)
      },
      failure: { [weak self] error in
        self?.showErrorToTheUser()
        completion(0, error)
      }
    )
  }
}
```

##### Custom pagination data

In the example above, we are letting `PagedTableView` to automatically detect if a new page request is necessary based on the number of elements loaded.

If your datasource provides data on pagination you can use that information to control when the table view loads new pages.

```swift
tableView.hasMore = requestData.isNextPageAvailable
```

#### Restart pagination

You can reset all pagination data on a table or collection view, for example, if you have a pull to refresh control.

```swift
dataSource.items = []
tableView.reloadData()
// Resets pagination
tableView.reset()
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Credits

**PagedLists** is maintained by [Rootstrap](http://www.rootstrap.com) and [German López](https://github.com/glm4) with the help of our [contributors](https://github.com/rootstrap/PagedLists/contributors).

## License

**PagedLists** is available under the MIT license. See the LICENSE file for more info.

[<img src="https://s3-us-west-1.amazonaws.com/rootstrap.com/img/rs.png" width="100"/>](http://www.rootstrap.com)

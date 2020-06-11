// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "PagedLists",
  platforms: [.iOS(.v9)],
  products: [
    .library(name: "PagedLists", targets: ["PagedLists"]),
  ],
  targets: [
    .target(name: "PagedLists", dependencies: [], path: "Sources")
  ]
)

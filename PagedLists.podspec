Pod::Spec.new do |s|
  s.name             = 'PagedLists'
  s.version          = '0.1.0'
  s.summary          = 'Paged UITableView and UICollectionView for iOS.'

  s.description      = <<-DESC
  Custom UITableView and UICollectionView classes to easily handle pagination.
  Mutiple scrolling direction pagination supported.
  Uses delegation to load content from your desired source.
                       DESC

  s.homepage         = 'https://github.com/rootstrap/PagedLists'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'German Lopez' => 'german@rootstrap.com' }
  s.source           = { :git => 'https://github.com/rootstrap/PagedLists.git', :tag => s.version.to_s }
  s.social_media_url = 'https://www.rootstrap.com/'
  

  s.ios.deployment_target = '9.3'

  s.source_files = 'PagedLists/Classes/**/*'
  s.frameworks = 'UIKit'
  s.swift_version = '5.2'
end

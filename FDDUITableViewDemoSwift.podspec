################################################################################################################
#   这个podspec文件是给我自己的私有Pod仓库做的，地址是：https://github.com/erduoniba/HDPodRepo.git
#   当想使用FDDBaseRepo库时，有两种方式：
#   1、Podfile中 添加 source https://github.com/erduoniba/HDPodRepo.git
#                    pod 'FDDUITableViewDemoSwift'
#   2、Podfile中添加  pod 'FDDUITableViewDemoSwift', :git => 'https://github.com/erduoniba/FDDUITableViewDemoSwift.git'
################################################################################################################

Pod::Spec.new do |s|
    s.name         = 'FDDUITableViewDemoSwift'
    s.version      = "0.1.2"
    s.license      = { :type => 'MIT', :file => 'LICENSE' }
    s.author       = { 'denglibing' => 'denglibing@fangdd.com' }
    s.summary      = 'FDDUITableViewDemoSwift'

    s.platform     =  :ios, '8.0'
    s.homepage     = "https://github.com/erduoniba/FDDUITableViewDemoSwift"

    s.source       =  { :git => 'https://github.com/erduoniba/FDDUITableViewDemoSwift.git', :tag => "#{s.version}"}
    s.module_name  = 'FDDUITableViewDemoSwift'
    s.framework    = 'UIKit'
    s.requires_arc = true

    # Pod Dependencies

    s.subspec 'FDDBaseRepo' do |ss|
        ss.source_files = 'FDDUITableViewDemoSwift/FDDBaseRepo/*'
        ss.resources = ["FDDUITableViewDemoSwift/FDDBaseRepo/Resources/*"]
        ss.dependency 'PullToRefresher'
    end
end

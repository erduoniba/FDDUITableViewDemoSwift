Pod::Spec.new do |s|
    s.name         = 'FDDUITableViewDemoSwift'
    s.version      = "0.1.1"
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

Pod::Spec.new do |s|
    s.name         = 'FDDUITableViewDemoSwift'
    s.version      = "0.0.2"
    s.license      = { :type => 'MIT', :file => 'LICENSE' }
    s.author       = { 'denglibing' => 'denglibing@fangdd.com' }
    s.summary      = 'FDDUITableViewDemoSwift'

    s.platform     =  :ios, '8.0'
    s.homepage     = "https://github.com/erduoniba/FDDUITableViewDemoSwift"

    s.source       =  { :git => 'https://github.com/erduoniba/FDDUITableViewDemoSwift.git', :tag => "#{s.version}"}
    s.module_name  = 'FDDUITableViewDemoSwift'
    s.framework    = 'UIKit'
    s.requires_arc = true

    s.source_files = 'FDDUITableViewDemoSwift/*'

    # Pod Dependencies

   # s.subspec 'BaseViewController' do |bvc|
   #     bvc.source_files = 'FDDCustomerCommon/BaseViewController/*'
   # end

   # s.subspec 'KTJPushQueueForNavigation' do |pqn|
   #     pqn.source_files = 'FDDCustomerCommon/KTJPushQueueForNavigation/*'
   # end

   # s.subspec 'ChatViewController' do |cvc|
   #     cvc.source_files = 'FDDCustomerCommon/FDDChatViewController/*'
   #     cvc.dependency 'IMIOSSDK'
   # end

end

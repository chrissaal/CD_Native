import UIKit
import React

@objcMembers
class ReactNativeViewController: UIViewController {
  
  private let moduleName: String
  private let initialProperties: [AnyHashable: Any]?
  private let reactBridge: RCTBridge
  
  init(moduleName: String,
       initialProperties: [AnyHashable: Any]?,
       reactBridge: RCTBridge) {
    self.moduleName = moduleName
    self.initialProperties = initialProperties
    self.reactBridge = reactBridge
    super.init(nibName: nil,
               bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let rootView = RCTRootView(bridge: self.reactBridge,
                               moduleName: self.moduleName,
                               initialProperties: self.initialProperties)
    
    // Set the frame of the root view to fill its container (your view controller's view)
    rootView.frame = self.view.bounds
    rootView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
    // Add the React Native root view as a subview
    self.view.addSubview(rootView)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.navigationController?.setNavigationBarHidden(true,
                                                      animated: true)
  }
}

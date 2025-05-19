//
//  CampusDigitalBridge.swift
//  CampusObjective
//
//  Created by Alex Vila Marsinyach on 12/6/24.
//

import UIKit
import CampusDigitalUIResources
import CampusDigitalServicesSDK

@objcMembers
class CampusDigitalBridge: NSObject {
  
  static let shared = CampusDigitalBridge()
  
  var isServicesSDKInit: Bool {
    return self.campusDigitalServices != nil
  }
  
  private var campusDigitalServices: CampusDigitalServices?
  
  private override init() {
    super.init()
  }
  
  func loadUniversiaFonts() {
    _ = UIFont.loadUniversiaFonts
  }
  
  func initServicesSDK(universiaToken: String,
                       navigationController: UINavigationController) async throws {
    let campusDigitalServicesConfig = CampusDigitalServicesConfig(universiaToken: universiaToken,
                                                                  navigationController: navigationController,
                                                                  errorNotifier: self)
    self.campusDigitalServices = try await CampusDigitalServicesImpl.campusDigitalServices(with: campusDigitalServicesConfig)
  }
  
  func getServiceList() async throws -> [Service] {
    guard let campusDigitalServices else {
      return []
    }
    
    return try await campusDigitalServices.campusDigitalServicesAPI.getServiceList()
  }
  
  func showSantanderMenu(viewController: UIViewController) async throws {
    try await self.campusDigitalServices?.showSantanderAdvantagesMenu(from: viewController)
  }
  
  func showBanner(viewController: UIViewController,
                  delegate: BannersCarouselDelegateBridge) -> UIView? {
    return self.campusDigitalServices?.getBannersCarousel(delegate: delegate,
                                                          from: viewController)
  }
  
  func getSDKVersion() -> String {
    return CampusDigitalServicesAPIImpl.getVersion()
  }
}

extension CampusDigitalBridge: CampusDigitalServicesErrorNotifier {
  
  func handle(error: CampusDigitalServicesError) {
    debugPrint("Error recived: \(error)")
  }
}

@objcMembers
class BannersCarouselDelegateBridge: NSObject, BannersCarouselDelegate {
  
  private let parentVC: UIViewController
  
  init(parentVC: UIViewController) {
    self.parentVC = parentVC
  }
  
  func bannerSelected(bannerDetailVC: UIViewController) {
    self.parentVC.navigationController?.pushViewController(bannerDetailVC,
                                                           animated: true)
  }
  
  func carouselBannerVisibilityUpdated(_ isHidden: Bool) {}
}

extension BannersCarouselDelegateBridge: UINavigationControllerDelegate {}

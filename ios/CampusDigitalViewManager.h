//
//  CampusDigitalViewManager.h
//  NativeSampleApp
//
//  Created by Carolina Carapia Ruiz on 25/06/24.
//

#import <React/RCTBridgeModule.h>
#import "NativeSampleApp-Swift.h"

@interface CampusDigitalViewManager : RCTViewManager
@property(nonatomic, strong) BannersCarouselDelegateBridge *instance;
@property(nonatomic, strong) UINavigationController * navController;
@property(nonatomic, strong) UIViewController *rootViewController;
@property(nonatomic, strong) CampusDigitalBridge * campusDigitalBridge;
@end

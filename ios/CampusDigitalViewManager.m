#import <React/RCTLog.h>
#import <React/RCTUIManager.h>
#import <React/RCTViewManager.h>
#import "AppDelegate.h"
#import "CampusDigitalView.h"
#import <React/RCTUtils.h>
@interface CampusDigitalViewManager : RCTViewManager
@property(nonatomic, strong) BannersCarouselDelegateBridge *instance;
@end
@implementation CampusDigitalViewManager
+ (BOOL)requiresMainQueueSetup
{
  return NO;
}
RCT_EXPORT_MODULE()
RCT_EXPORT_METHOD(initServicesSDK : (nonnull NSNumber *)reactTag token : (NSString *)token)
{
  [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *, UIView *> *viewRegistry) {
    UIView *view = viewRegistry[reactTag];
    if (!view || ![view isKindOfClass:[UIView class]]) {
      RCTLogError(@"Cannot find NativeView with tag #%@", reactTag);
      return;
    }
    
    CampusDigitalBridge * bridge = [CampusDigitalBridge shared];
    
    if (bridge.isServicesSDKInit) {
      NSLog(@"Sdk is init previously");
    } else {
      NSString * universiaToken = token; // Enter valid Universia Token
      UINavigationController *navigationController = [self getCurrentNavigationController];
      
      NSLog(@"navController %@", navigationController);
      
      [bridge initServicesSDKWithUniversiaToken:universiaToken navigationController:navigationController completionHandler:^(NSError* error) {
        if (error != nil) {
          NSLog(@"Error is init sdk view manager %@", error);
        } else {
          NSLog(@"SDK init OK");
        }
      }];
    }
  }];
}

RCT_EXPORT_METHOD(showBannerIos : (nonnull NSNumber *)reactTag token : (NSString *)token)
{
  [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *, UIView *> *viewRegistry) {
    UIView *view = viewRegistry[reactTag];
    if (!view || ![view isKindOfClass:[UIView class]]) {
      RCTLogError(@"Cannot find NativeView with tag #%@", reactTag);
      return;
    }
    CampusDigitalBridge * bridge = [CampusDigitalBridge shared];
    if (!bridge.isServicesSDKInit) {
      NSLog(@"Sdk is not init");
      return;
    }
    
    UINavigationController *nController = [self getCurrentNavigationController];
    NSLog(@"navController %@", nController);
    
    UIViewController *topViewController = [self getRootViewController];
    NSLog(@"topViewController %@", topViewController);
    
    self.instance = [[BannersCarouselDelegateBridge alloc] initWithParentVC:topViewController];
    UIView * bannersCarousel = [bridge showBannerWithViewController: topViewController delegate: self.instance];
    [view addSubview:bannersCarousel];
    [bannersCarousel.topAnchor constraintEqualToAnchor:view.safeAreaLayoutGuide.topAnchor].active = YES;
    [bannersCarousel.leadingAnchor constraintEqualToAnchor:view.safeAreaLayoutGuide.leadingAnchor].active = YES;
    [bannersCarousel.trailingAnchor constraintEqualToAnchor:view.safeAreaLayoutGuide.trailingAnchor].active = YES;
  }];
}

RCT_EXPORT_METHOD(showMenuIos : (nonnull NSNumber *)reactTag)
{
  [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *, UIView *> *viewRegistry) {
    UIView *view = viewRegistry[reactTag];
    if (!view || ![view isKindOfClass:[UIView class]]) {
      RCTLogError(@"Cannot find NativeView with tag #%@", reactTag);
      return;
    }
    CampusDigitalBridge * bridge = [CampusDigitalBridge shared];
    if (!bridge.isServicesSDKInit) {
      NSLog(@"Sdk is not init");
      return;
    }
    
    UIViewController *topViewController = [self getRootViewController];
    NSLog(@"topViewController %@", topViewController);
    
    [bridge showSantanderMenuWithViewController:topViewController completionHandler:^(NSError* error) {
      if (error != nil) {
        NSLog(@"Error is show menu view manager%@", error);
      } else {
        NSLog(@"Show menu OK");
      }
    }];
  }];
}

- (UIView *)view
{
  CampusDigitalView *view = [[CampusDigitalView alloc] init];
  return view;
}

- (UINavigationController *)getCurrentNavigationController {
  UIApplication *application = [UIApplication sharedApplication];
  UIWindow *window = application.windows.firstObject;
  UIViewController *rootViewController = window.rootViewController;
  
  UINavigationController *navigationController = nil;
  while (rootViewController) {
    if ([rootViewController isKindOfClass:[UINavigationController class]]) {
      navigationController = (UINavigationController *)rootViewController;
      break;
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
      navigationController = (UINavigationController *)rootViewController;
      break;
    }
    
    rootViewController = rootViewController.presentedViewController ? : [rootViewController.childViewControllers firstObject];
  }
  
  return navigationController;
}

- (UIViewController *)getRootViewController {
  UINavigationController *nController = [self getCurrentNavigationController];
  UIViewController *rootViewController = nController.visibleViewController;
  
  return [self findTopNonRNSScreenViewController:rootViewController];
}

- (UIViewController *)findTopNonRNSScreenViewController:(UIViewController *)vc {
    if (vc.presentedViewController) {
        return [self findTopNonRNSScreenViewController:vc.presentedViewController];
    }
    
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self findTopNonRNSScreenViewController:[(UINavigationController *)vc visibleViewController]];
    }
    
    if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self findTopNonRNSScreenViewController:[(UITabBarController *)vc selectedViewController]];
    }
    
    if ([vc isKindOfClass:NSClassFromString(@"RNSScreen")]) {
        for (UIViewController *childVC in vc.childViewControllers) {
            UIViewController *foundVC = [self findTopNonRNSScreenViewController:childVC];
            if (![foundVC isKindOfClass:NSClassFromString(@"RNSScreen")]) {
                return foundVC;
            }
        }
    }

    return vc;
}

@end

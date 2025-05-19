#import "AppDelegate.h"

#import <React/RCTBundleURLProvider.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.moduleName = @"NativeSampleApp";
  self.initialProps = @{};
  
  RCTBridge *reactBridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:launchOptions];

  // Step required, need to load Universia fonts for Campus screens
  CampusDigitalBridge * bridge = [CampusDigitalBridge shared];
  [bridge loadUniversiaFonts];
    
  ReactNativeViewController *rootViewController = [[ReactNativeViewController alloc] initWithModuleName:self.moduleName initialProperties:self.initialProps reactBridge:reactBridge];

  NSLog(@"rootViewController %@", rootViewController);

  UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
   NSLog(@"navController %@", navController);

  [navController setModalPresentationStyle:UIModalPresentationFullScreen];
  [navController setNavigationBarHidden:YES animated:YES];

  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  self.window.rootViewController = navController;

  NSLog(@"windowrootViewController %@", self.window.rootViewController);
  [self.window makeKeyAndVisible];
    
  return YES;
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
  return [self bundleURL];
}

- (NSURL *)bundleURL
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index"];
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}

@end

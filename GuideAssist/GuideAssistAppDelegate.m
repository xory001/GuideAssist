//
//  GuideAssistAppDelegate.m
//  GuideAssist
//
//  Created by 朱 起伟 on 11-8-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "GuideAssistAppDelegate.h"

#import "LoginViewController.h"
#import "MainViewController.h"


#import "CDataTypeDef.h"
#import "CWebServiceAccess.h"

GuideAssistAppDelegate *g_pAppDelegate = nil;

@implementation GuideAssistAppDelegate

@synthesize bgImgColor = pbgImgColor_;
@synthesize dataAccess = pDataAccess_;
@synthesize window = _window;
@synthesize loginViewContrller = ploginViewContrller_;
@synthesize frameApp = frameApp_;

//@dynamic boundKeyboard;

//- (CGRect)boundKeyboard
//{
//    return keyboardObserver_.keyboardBound;
//}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    g_pAppDelegate = self;
    
   // keyboardObserver_ = [[ CKeyBroardObserber alloc ] init ];
    
    frameApp_ = [[ UIScreen mainScreen ] applicationFrame ];
    pDataAccess_ = [[ CDBAccess alloc ] init ];
    NSString *pstrImg = [ [NSBundle mainBundle ] pathForResource:@"bg" 
                                                          ofType:@"png" 
                                                     inDirectory:@"resource" ];
     pbgImgColor_ = [[ UIColor alloc ] initWithPatternImage:[ UIImage imageWithContentsOfFile:pstrImg ] ];
    
    // Override point for customization after application launch.
  ploginViewContrller_  = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    ploginViewContrller_.view.frame = frameApp_;
  [self.window addSubview:ploginViewContrller_.view];
  [self.window makeKeyAndVisible];

     // webservice test
//    CWebServiceAccess *pWebService = [[[ CWebServiceAccess alloc ] init ] autorelease ];
//    pWebService.dbAccess = pDataAccess_;
//    pWebService.url = @"http://60.191.115.39:8080/tvlsys/TourHelperService/tourHelper";
//    pWebService.icCardNumber = @"712936";
//    pWebService.guidePhone = @"15305712936";
//    NSString *pstrErr = nil;
//   // [ pWebService userLogin: &pstrErr ];
//    [ pWebService syncItineraryInfo:nil ];
    
   return YES;
}

- (void)ShowMainView
{
     MainViewController *pmainViewContrller = 
                [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
     pmainViewContrller.view.frame = frameApp_;
    
    if ( nil == pnavc_ )
    {
        pnavc_ = [[ UINavigationController alloc ] initWithRootViewController: pmainViewContrller ];
    }
   // [ pnavc_ pushViewController: pmainViewContrller animated:NO ];
    [ pmainViewContrller release ];
    
//  [UIView beginAnimations:nil context:nil];
//  [UIView setAnimationDuration:1];
//    [ UIView setAnimationCurve:UIViewAnimationCurveEaseIn ];
////  [self.window addSubview:self.mainViewContrller.view];
//    
//    [ self.window addSubview:self.groupMemberListController.view ];
//
//  [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft 
//                         forView:self.window cache:NO];
//  
// // [self.window addSubview:mainViewContrller_.view];
////  [mainViewContrller_.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0]; 
//    
//  [UIView commitAnimations];
    
    CATransition *pAnimotion = [ CATransition animation ];
//    [ pAnimotion setType:@"pageCurl" ]; //@"suckEffect"  @"cube" rippleEffect
    [ pAnimotion setType: kCATransitionPush ];
    [ pAnimotion setSubtype:kCATransitionFromRight ];
    [ pAnimotion setDuration:0.39 ];
    [ self.window.layer addAnimation:pAnimotion forKey:nil ];
    [ self.window addSubview:pnavc_.view ];
    
  
    [self.loginViewContrller.view removeFromSuperview];
    self.loginViewContrller = nil;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
  /*
   Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
   Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
   */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  /*
   Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
   If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
   */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  /*
   Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
   */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  /*
   Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  /*
   Called when the application is about to terminate.
   Save data if appropriate.
   See also applicationDidEnterBackground:.
   */
}

- (void)dealloc
{
 //   [ keyboardObserver_ release ];
    [ pnavc_ release ];
    self.loginViewContrller = nil;
    [_window release];
    [ pDataAccess_ release ];
    [ pbgImgColor_ release ];
    [super dealloc];
    
    g_pAppDelegate = nil;
}

@end

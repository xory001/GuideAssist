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

@implementation GuideAssistAppDelegate


@synthesize window=_window;
@synthesize loginViewContrller_, mainViewContrller_;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
  loginViewContrller_  = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
 // [self.window insertSubview:loginViewContrller_.view atIndex:0];
  [self.window addSubview:loginViewContrller_.view];
  [self.window makeKeyAndVisible];
  NSString *strPath = [[NSBundle mainBundle] resourcePath]; 
  NSLog( @"%@", strPath );
  NSURL *strURL = [[ NSBundle mainBundle] resourceURL];
  NSLog(@"%@", strURL);
 // [self.window set sett];
  
   return YES;
}

- (void)ShowMainView
{
  if ( nil == mainViewContrller_ ) 
  {
    mainViewContrller_ = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
  }
//  [self.window insertSubview:mainViewContrller_.view
//                belowSubview:loginViewContrller_.view];
//  [self.window insertSubview:mainViewContrller_.view atIndex:0];
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:1];
  [self.window addSubview:mainViewContrller_.view];

  [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft 
                         forView:self.window cache:NO];
  
 // [self.window addSubview:mainViewContrller_.view];
//  [mainViewContrller_.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0]; 
    
  [UIView commitAnimations];
  
  [loginViewContrller_.view removeFromSuperview];
  [loginViewContrller_ release];
  loginViewContrller_ = nil;
   
    

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
  [loginViewContrller_ release];
  [mainViewContrller_ release];
  [_window release];
    [super dealloc];
}

@end

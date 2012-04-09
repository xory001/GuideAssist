//
//  GuideAssistAppDelegate.h
//  GuideAssist
//
//  Created by 朱 起伟 on 11-8-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class LoginViewController;
@class MainViewController;

@interface GuideAssistAppDelegate : NSObject <UIApplicationDelegate> {
  
  LoginViewController *loginViewContrller_;
  MainViewController *mainViewContrller_;

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, getter = loginViewController, readonly) LoginViewController *loginViewContrller_;
@property (nonatomic, getter = mainViewContrller, readonly) MainViewController *mainViewContrller_;


- (void)ShowMainView;

@end

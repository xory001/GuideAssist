//
//  GuideAssistAppDelegate.h
//  GuideAssist
//
//  Created by 朱 起伟 on 11-8-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CDBAccess.h"

@class LoginViewController;


@interface GuideAssistAppDelegate : NSObject <UIApplicationDelegate> {
  
    LoginViewController *ploginViewContrller_;
   
    CDBAccess *pDataAccess_;
    CGRect frameApp_;
    UINavigationController *pnavc_;

}

@property ( nonatomic, retain) IBOutlet UIWindow *window;
@property ( nonatomic, retain ) LoginViewController *loginViewContrller;
@property ( nonatomic, readonly ) CDBAccess *dataAccess;


- (void)ShowMainView;

@end

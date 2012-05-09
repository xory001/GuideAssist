//
//  GuideAssistAppDelegate.h
//  GuideAssist
//
//  Created by 朱 起伟 on 11-8-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDBAccess.h"

@class LoginViewController;
@class MainViewController;
@class CGroupMemberListController;


@interface GuideAssistAppDelegate : NSObject <UIApplicationDelegate> {
  
    LoginViewController *ploginViewContrller_;
    MainViewController *pmainViewContrller_;
    CGroupMemberListController *pGroupMemberListController_;
    CDBAccess *pDataAccess_;
    CGRect frameApp_;

}

@property ( nonatomic, retain) IBOutlet UIWindow *window;
@property ( nonatomic, retain ) LoginViewController *loginViewContrller;
@property ( nonatomic, retain ) MainViewController *mainViewContrller;
@property ( nonatomic, retain ) CGroupMemberListController *groupMemberListController;

@property ( nonatomic, readonly ) CDBAccess *dataAccess;


- (void)ShowMainView;

@end

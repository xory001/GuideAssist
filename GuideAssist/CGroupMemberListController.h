//
//  CGroupMemberListController.h
//  GuideAssist
//
//  Created by 朱 起伟 on 12-5-9.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDBAccess.h"


@interface CGroupMemberListController : UIViewController < UITableViewDelegate, UITableViewDataSource > 
{
    UITableView *pGroupMemberTabView_;
    NSMutableArray *pArrGroupMember_;
    CDBAccess *pDBAccess_;
    NSInteger nMaxTableItemShowing_;
    NSString *pstrResoucePath_;
}

- (BOOL)loadData:(NSString*)pstrMainItineraryNumber;


@end

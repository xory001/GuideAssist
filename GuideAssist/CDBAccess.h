//
//  CDBAccess.h
//  GuideAssist
//
//  Created by 朱 起伟 on 12-4-10.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "/usr/include/sqlite3.h"
#import "CDataTypeDef.h"

@interface CDBAccess : NSObject 
{
    sqlite3 *pSQLite3_;
    NSString *pstrDatabaseFile_;
}

- (BOOL)executeSQL:(char*)pszSQL;
- (BOOL)initDatabase;

//main itinerary
- (BOOL)insertMainItinerary:(CMainItinerary*)pMainIniterary retID:(UInt32*)puNid;

//detail itinerary
- (BOOL)insertDetailItinerary:(CDetailItinerary*)pDetailItinerary;

//group member
- (BOOL)insertGroupMember:(CGroupMember*)pGroupMember;



@end

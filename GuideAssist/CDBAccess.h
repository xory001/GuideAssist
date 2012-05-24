//
//  CDBAccess.h
//  GuideAssist
//
//  Created by 朱 起伟 on 12-4-10.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
//#import "/usr/include/sqlite3.h"
#import "CDataTypeDef.h"

@interface CDBAccess : NSObject 
{
    FMDatabase *dbSQlite_;
    NSString *pstrDatabaseFile_;
  //  CDBAccess *sharedInstance_;
}

+ (CDBAccess*)sharedInstance;

- (void)initDateTable;

//main itinerary
- (BOOL)insertMainItinerary:(CMainItinerary*)pMainIniterary;
- (BOOL)getAllMainItinerarySerialNumber:(NSMutableArray*)parrMainSerialNumber;
- (BOOL)deleteItineraryBySerialNumber:(NSString*)pstrSerialNumber;
- (BOOL)deleteGroupMemberInfoByBySerialNumber:(NSString*)pstrSerialNumber;
- (BOOL)getMainItineraryNumber:(NSMutableArray*)arrNumber 
                    byStartDay:(NSString*)strStartDay 
                     andEndDay:(NSString*)strEndDay;


//detail itinerary
- (BOOL)insertDetailItinerary:(CDetailItinerary*)pDetailItinerary;
- (BOOL)getAllDetailItinerary:(NSMutableArray*)parrDetail 
           ByMainSerialNumber:( NSString *)pstrMainSerialNumber;


//group member
- (BOOL)insertGroupMember:(CGroupMember*)pGroupMember;
- (BOOL)getAllGroupMember:(NSMutableArray*)parrGroupMember 
       ByMainSerialNumber:( NSString *)pstrMainSerialNumber;



@end

//
//  CDBAccess.m
//  GuideAssist
//
//  Created by 朱 起伟 on 12-4-10.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CDBAccess.h"
#import "/usr/include/sqlite3.h"


@implementation CDBAccess

- (id)init
{
    self = [ super init ];
    if ( self )
    {
        NSString *pstrDocPath = [ NSSearchPathForDirectoriesInDomains
                             ( NSDocumentDirectory, NSUserDomainMask, YES ) lastObject ];
        pstrDatabaseFile_ = [[ NSString alloc ] initWithFormat: @"%@/GuideAssist.db", pstrDocPath ];
        if ( ![[ NSFileManager defaultManager ] fileExistsAtPath: pstrDatabaseFile_ ] )
        {
            if( SQLITE_OK != sqlite3_open( [ pstrDatabaseFile_ UTF8String ], &pSQLite3_ ) )
            {
                pSQLite3_ = NULL;
                return nil;
            }
        [ self initDatabase ];
        }
    }
    
    return self;
}

- (void)dealloc
{
    if ( pSQLite3_ )
    {
        sqlite3_close( pSQLite3_ );
    }
    
    [ pstrDatabaseFile_ release ];
    
    [ super dealloc ];
}

//*******main itinerary
- (BOOL)insertMainItinerary:(CMainItinerary *)pMainIniterary retID:(UInt32 *)puNid
{
    
    return NO;
}

- (BOOL)getAllMainItineraryDateAndID:(NSMutableArray *)parrDateID
{
    return NO;
}



//*********detail itinerary
- (BOOL)insertDetailItinerary:(CDetailItinerary *)pDetailItinerary
{
    return NO;
}

- (BOOL)getAllDetailItinerary:(NSMutableArray *)parrDetail ByMainID:(uint32_t)uMainID
{
    return NO;
}


//**************group member
- (BOOL)insertGroupMember:(CGroupMember *)pGroupMember
{
    return NO;    
}


- (BOOL)getAllGroupMember:(NSMutableArray *)parrGroupMember byMainID:(uint32_t)uMainID
{
    return NO;
}



- (BOOL)initDatabase
{
    char *pstrCreateMainItineraryTable = 
    "create table tb_MainItinerary \
    ( id INTEGER PRIMARY KEY AUTOINCREMENT, \
    timeStamp TEXT, \
    tourGroupName TEXT, \
    travelAgencyName TEXT, \
    memberCount INTEGER, \
    statDay TEXT, \
    endDay TEXT, \
    standardCost TEXT, \
    roomCost TEXT, \
    mealCost TEXT, \
    trafficCost TEXT, \
    personalTotalCost TEXT, \
    groupTotalCost TEXT, \
    ticketCost TEXT )";
    [ self executeSQL:pstrCreateMainItineraryTable ];
    
    char *pstrCreateDetailItineraryTable =
    "create table tb_DetailItinerary \
    ( id INTEGER PRIMARY KEY AUTOINCREMENT, \
    mianid INTEGER, \
    index INTEGER, \
    day TEXT, \
    traffic TEXT, \
    trafficNo TEXT, \
    driverName INTEGER, \
    driverPhone TEXT, \
    city TEXT, \
    meal TEXT, \
    toom TEXT, \
    detailDesc TEXT, \
    localTravelAgencyName TEXT, \
    localGuide TEXT, \
    localGuidePhone TEXT )";
    [ self executeSQL:pstrCreateDetailItineraryTable ];

    
    char *pstrCreateGroupMemberTable =
    "create table tb_DetailItinerary \
    ( id INTEGER PRIMARY KEY AUTOINCREMENT, \
    paid INTEGER, \
    name TEXT, \
    sex TEXT, \
    age TEXT, \
    remark INTEGER, \
    phone TEXT, \
    idCardType TEXT, \
    idCardNumber TEXT )";
    [ self executeSQL:pstrCreateGroupMemberTable ];

    return YES;
                        
}

- (BOOL)executeSQL:(char*)pszSQL
{
    char *pszErrString = NULL;
    sqlite3_exec( pSQLite3_, pszSQL, NULL, NULL, &pszErrString );
    if ( pszErrString )
    {
        NSLog( @"%s", pszErrString );
        sqlite3_free( pszErrString );
        return NO;
    }
    return YES;
}

@end

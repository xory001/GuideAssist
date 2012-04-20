//
//  CDBAccess.m
//  GuideAssist
//
//  Created by 朱 起伟 on 12-4-10.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CDBAccess.h"
#import "/usr/include/sqlite3.h"

static CDBAccess *g_sharedInstance = nil;

@implementation CDBAccess


+ (CDBAccess*)sharedInstance
{
    if ( [NSThread currentThread].isMainThread )
    {
        return nil; //[[[self alloc] init] autorelease];
    }
    else if(!g_sharedInstance) 
    {
        g_sharedInstance = [[self alloc] init];
    }
    return g_sharedInstance;
}

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
- (BOOL)insertMainItinerary:(CMainItinerary *)pMainIniterary
{
    NSString *pstrSQL = [[ NSString alloc ] initWithFormat: 
    @"insert into tb_MainItinerary( SerialNumber, timeStamp, tourGroupName, travelAgencyName, \
     memberCount, statDay, endDay, standardCost, roomCost, mealCost, trafficCost, \
     personalTotalCost, groupTotalCost, ticketCost ) \
     values('%@', '%@', '%@', '%@', %d, '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')", 
     pMainIniterary.serialNumber, pMainIniterary.timeStamp, pMainIniterary.tourGroupName, 
                         pMainIniterary.travelAgencyName,
     pMainIniterary.memberCount, pMainIniterary.startDay, pMainIniterary.endDay,
     pMainIniterary.standardCost, pMainIniterary.roomCost, pMainIniterary.mealCost,
     pMainIniterary.trafficCost, pMainIniterary.personalTotalCost, 
     pMainIniterary.groupTotalCost, pMainIniterary.ticketCost ];
    
    BOOL bRet = [ self executeSQLA: [ pstrSQL UTF8String ] ];
    [ pstrSQL release ];
    return bRet;
    
}

- (BOOL)getAllMainItinerarySerialNumber:(NSMutableArray*)parrMainSerialNumber
{
    BOOL bRet = NO;
    NSString *pstrSQL = [[ NSString alloc ] initWithString:
                         @"select id, statDay from tb_MainItinerary"];
    sqlite3_stmt *pstmt = NULL;
    
    if ( SQLITE_OK == sqlite3_prepare_v2( pSQLite3_, [ pstrSQL UTF8String ], -1, &pstmt, NULL) )
    {
        CMainItinerarySerialNumner *pMainItinerarySerialNumner = NULL;
        NSString *pstrTemp = NULL;
        while ( SQLITE_ROW == sqlite3_step( pstmt ) )
        {
            pMainItinerarySerialNumner = [[ CMainItinerarySerialNumner alloc ] init ];
           
            pstrTemp = [ [ NSString alloc ] initWithUTF8String:
                        ( const char *)sqlite3_column_text( pstmt, 0 ) ];
            pMainItinerarySerialNumner.serialNumner = pstrTemp;
            [ pstrTemp release ];

            pstrTemp = [ [ NSString alloc ] initWithUTF8String:
               ( const char *)sqlite3_column_text( pstmt, 1 ) ];
            pMainItinerarySerialNumner.date = pstrTemp;
            [ pstrTemp release ];
            
            [ parrMainSerialNumber addObject: pMainItinerarySerialNumner ];
            [ pMainItinerarySerialNumner release ];
            
        }
        sqlite3_finalize( pstmt );
        bRet = YES;
    }
    
    
    [ pstrSQL release ];
    
    return YES;
}

- (BOOL)deleteItineraryBySerialNumber:(NSString *)pstrSerialNumber
{
    NSString *pstrSQL = [[ NSString alloc ] initWithFormat:
                         @"delet from tb_MainItinerary where SerialNumber = '%@'",
                         pstrSerialNumber ];
    [ self executeSQLA: [ pstrSQL UTF8String ]];
    [ pstrSQL release ];
    
    pstrSQL = [[ NSString alloc ] initWithFormat:
                         @"delet from tb_DetailItinerary where SerialNumber = '%@'",
                         pstrSerialNumber ];
    [ self executeSQLA: [ pstrSQL UTF8String ]];
    [ pstrSQL release ];
    

    return YES;    
     
}

//*********detail itinerary
- (BOOL)insertDetailItinerary:(CDetailItinerary *)pDetailItinerary
{
    
    NSString *pstrSQL = [[ NSString alloc ] initWithFormat: 
                         @"insert into tb_DetailItinerary( index, serialNumber, day, \
                         traffic, trafficNo, driverName, driverPhone, city, meal, room, \
                         detailDesc, localTravelAgencyName, localGuide, localGuidePhone ) \
                         values(%u, %d, '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')", 
                         pDetailItinerary.index, pDetailItinerary.serialNumber, pDetailItinerary.day,
                         pDetailItinerary.traffic, pDetailItinerary.trafficNo, pDetailItinerary.driverName,
                         pDetailItinerary.driverPhone, pDetailItinerary.city, pDetailItinerary.meal,
                         pDetailItinerary.room, pDetailItinerary.detailDesc, 
                         pDetailItinerary.localTravelAgencyName, pDetailItinerary.localGuide,
                         pDetailItinerary.localGuidePhone ];
        
    BOOL bRet = [ self executeSQLA: [ pstrSQL UTF8String ] ];
    [ pstrSQL release ];
    return bRet;

}

- (BOOL)getAllDetailItinerary:(NSMutableArray*)parrDetail ByMainSerialNumber:( NSString *)pstrMainSerialNumber;
{
    BOOL bRet = NO;
    NSString *pstrSQL = [[ NSString alloc ] initWithFormat:
                         @"select * from tb_DetailItinerary where serialNumber = '%@'", pstrMainSerialNumber ];
    sqlite3_stmt *pstmt = NULL;
    
    if ( SQLITE_OK == sqlite3_prepare_v2( pSQLite3_, [ pstrSQL UTF8String ], -1, &pstmt, NULL) )
    {
        CDetailItinerary *pDetailItinerary = NULL;
        NSString *pstrTemp = NULL;
        while ( SQLITE_ROW == sqlite3_step( pstmt ) )
        {
            pDetailItinerary = [[ CDetailItinerary alloc ] init ];
            pDetailItinerary.uid = sqlite3_column_int( pstmt, 0 );
            pDetailItinerary.index = sqlite3_column_int( pstmt, 1 );
            
            pstrTemp = [ [ NSString alloc ] initWithUTF8String:
                        ( const char *)sqlite3_column_text( pstmt, 2 ) ];
            pDetailItinerary.serialNumber = pstrTemp;
            [ pstrTemp release ];
            
            pstrTemp = [ [ NSString alloc ] initWithUTF8String:
                        ( const char *)sqlite3_column_text( pstmt, 3 ) ];
            pDetailItinerary.day = pstrTemp;
            [ pstrTemp release ];
            
            pstrTemp = [ [ NSString alloc ] initWithUTF8String:
                        ( const char *)sqlite3_column_text( pstmt, 4 ) ];
            pDetailItinerary.traffic = pstrTemp;
            [ pstrTemp release ];
            
            pstrTemp = [ [ NSString alloc ] initWithUTF8String:
                        ( const char *)sqlite3_column_text( pstmt, 5 ) ];
            pDetailItinerary.trafficNo = pstrTemp;
            [ pstrTemp release ];
            
            pstrTemp = [ [ NSString alloc ] initWithUTF8String:
                        ( const char *)sqlite3_column_text( pstmt, 6 ) ];
            pDetailItinerary.driverName = pstrTemp;
            [ pstrTemp release ];
            
            pstrTemp = [ [ NSString alloc ] initWithUTF8String:
                        ( const char *)sqlite3_column_text( pstmt, 7 ) ];
            pDetailItinerary.driverPhone = pstrTemp;
            [ pstrTemp release ];
            
            pstrTemp = [ [ NSString alloc ] initWithUTF8String:
                        ( const char *)sqlite3_column_text( pstmt, 8 ) ];
            pDetailItinerary.city = pstrTemp;
            [ pstrTemp release ];
            
            pstrTemp = [ [ NSString alloc ] initWithUTF8String:
                        ( const char *)sqlite3_column_text( pstmt, 9 ) ];
            pDetailItinerary.meal = pstrTemp;
            [ pstrTemp release ];
            
            pstrTemp = [ [ NSString alloc ] initWithUTF8String:
                        ( const char *)sqlite3_column_text( pstmt, 10 ) ];
            pDetailItinerary.room = pstrTemp;
            [ pstrTemp release ];
            
            pstrTemp = [ [ NSString alloc ] initWithUTF8String:
                        ( const char *)sqlite3_column_text( pstmt, 11 ) ];
            pDetailItinerary.detailDesc = pstrTemp;
            [ pstrTemp release ];
            
            pstrTemp = [ [ NSString alloc ] initWithUTF8String:
                        ( const char *)sqlite3_column_text( pstmt, 12 ) ];
            pDetailItinerary.localTravelAgencyName = pstrTemp;
            [ pstrTemp release ];
            
            pstrTemp = [ [ NSString alloc ] initWithUTF8String:
                        ( const char *)sqlite3_column_text( pstmt, 13 ) ];
            pDetailItinerary.localGuide = pstrTemp;
            [ pstrTemp release ];
            
            pstrTemp = [ [ NSString alloc ] initWithUTF8String:
                        ( const char *)sqlite3_column_text( pstmt, 14 ) ];
            pDetailItinerary.localGuidePhone = pstrTemp;
            [ pstrTemp release ];
            
            [ parrDetail addObject: pDetailItinerary ];
            [ pDetailItinerary release ];
            
        }
        sqlite3_finalize( pstmt );
        bRet = YES;
    }

    
    return bRet;
}


//**************group member
- (BOOL)insertGroupMember:(CGroupMember *)pGroupMember
{
    NSString *pstrSQL = [[ NSString alloc ] initWithFormat: 
                         @"insert into tb_GroupMember( paid, serialNumber, \
                         name, sex, age, remark, phone, idCardType, \
                         idCardType ) values( %d, '%@', '%@', '%@', '%@', '%@', \
                         '%@', '%@', '%@' )", 
                         pGroupMember.paid, pGroupMember.serialNumber, pGroupMember.name,
                         pGroupMember.sex, pGroupMember.age, pGroupMember.remark,
                         pGroupMember.phone, pGroupMember.idCardType, pGroupMember.idCardNumber ];
    
    BOOL bRet = [ self executeSQLA: [ pstrSQL UTF8String ] ];
    [ pstrSQL release ];
    return bRet;

}

- (BOOL)deleteGroupMemberInfoByBySerialNumber:(NSString *)pstrSerialNumber
{
    NSString *pstrSQL = [[ NSString alloc ] initWithFormat:
               @"delet from tb_GroupMember where SerialNumber = '%@'",
               pstrSerialNumber ];
    [ self executeSQLA: [ pstrSQL UTF8String ]];
    [ pstrSQL release ];
    return YES;
}

- (BOOL)getAllGroupMember:(NSMutableArray*)parrGroupMember ByMainSerialNumber:( NSString *)pstrMainSerialNumber;
{
    BOOL bRet = NO;
    NSString *pstrSQL = [[ NSString alloc ] initWithFormat:
                         @"select * from tb_DetailItinerary where serialNumber = '%@'", pstrMainSerialNumber ];
    sqlite3_stmt *pstmt = NULL;
    
    if ( SQLITE_OK == sqlite3_prepare_v2( pSQLite3_, [ pstrSQL UTF8String ], -1, &pstmt, NULL) )
    {
        CGroupMember *pGroupMember = NULL;
        NSString *pstrTemp = NULL;
        while ( SQLITE_ROW == sqlite3_step( pstmt ) )
        {
            pGroupMember = [[ CGroupMember alloc ] init ];
            pGroupMember.uid = sqlite3_column_int( pstmt, 0 );
            pGroupMember.paid = sqlite3_column_int( pstmt, 1 );
            
            pstrTemp = [ [ NSString alloc ] initWithUTF8String:
                        ( const char *)sqlite3_column_text( pstmt, 2 ) ];
            pGroupMember.serialNumber = pstrTemp;
                   
            pstrTemp = [ [ NSString alloc ] initWithUTF8String:
                        ( const char *)sqlite3_column_text( pstmt, 3 ) ];
            pGroupMember.name = pstrTemp;
            [ pstrTemp release ];
            
            pstrTemp = [ [ NSString alloc ] initWithUTF8String:
                        ( const char *)sqlite3_column_text( pstmt, 4 ) ];
            pGroupMember.sex = pstrTemp;
            [ pstrTemp release ];
            
            pstrTemp = [ [ NSString alloc ] initWithUTF8String:
                        ( const char *)sqlite3_column_text( pstmt, 5 ) ];
            pGroupMember.age = pstrTemp;
            [ pstrTemp release ];
            
            pstrTemp = [ [ NSString alloc ] initWithUTF8String:
                        ( const char *)sqlite3_column_text( pstmt, 6 ) ];
            pGroupMember.remark = pstrTemp;
            [ pstrTemp release ];
            
            pstrTemp = [ [ NSString alloc ] initWithUTF8String:
                        ( const char *)sqlite3_column_text( pstmt, 7 ) ];
            pGroupMember.phone = pstrTemp;
            [ pstrTemp release ];
            
            pstrTemp = [ [ NSString alloc ] initWithUTF8String:
                        ( const char *)sqlite3_column_text( pstmt, 8 ) ];
            pGroupMember.idCardType = pstrTemp;
            [ pstrTemp release ];

            pstrTemp = [ [ NSString alloc ] initWithUTF8String:
                        ( const char *)sqlite3_column_text( pstmt, 9 ) ];
            pGroupMember.idCardNumber = pstrTemp;
            [ pstrTemp release ];
            
            [ parrGroupMember addObject: pGroupMember ];
            [ pGroupMember release ];

        }
        sqlite3_finalize( pstmt );
        bRet = YES;
    }
    
    return bRet;
}



- (BOOL)initDatabase
{
    char *pstrCreateMainItineraryTable = 
    "create table tb_MainItinerary \
    ( id INTEGER PRIMARY KEY AUTOINCREMENT, \
    SerialNumber TEXT, \
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
    [ self executeSQLA:pstrCreateMainItineraryTable ];
    
    char *pstrCreateDetailItineraryTable =
    "create table tb_DetailItinerary \
    ( id INTEGER PRIMARY KEY AUTOINCREMENT, \
    index INTEGER, \
    serialNumber TEXT, \
    day TEXT, \
    traffic TEXT, \
    trafficNo TEXT, \
    driverName INTEGER, \
    driverPhone TEXT, \
    city TEXT, \
    meal TEXT, \
    room TEXT, \
    detailDesc TEXT, \
    localTravelAgencyName TEXT, \
    localGuide TEXT, \
    localGuidePhone TEXT )";
    [ self executeSQLA:pstrCreateDetailItineraryTable ];

    
    char *pstrCreateGroupMemberTable =
    "create table tb_GroupMember \
    ( id INTEGER PRIMARY KEY AUTOINCREMENT, \
    paid INTEGER, \
    serialNumber TEXT, \
    name TEXT, \
    sex TEXT, \
    age TEXT, \
    remark INTEGER, \
    phone TEXT, \
    idCardType TEXT, \
    idCardNumber TEXT )";
    [ self executeSQLA:pstrCreateGroupMemberTable ];

    return YES;
                        
}

- (BOOL)executeSQLA:(const char*)pszSQL
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

- (BOOL)executeSQLW:(wchar_t *)pwszSQL
{
    return NO;
}

@end

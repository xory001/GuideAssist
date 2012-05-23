//
//  CDBAccess.m
//  GuideAssist
//
//  Created by 朱 起伟 on 12-4-10.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CDBAccess.h"
#import "/usr/include/sqlite3.h"
#import "DebugMacroDefine.h"

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
        
        NSFileManager *fm = [ NSFileManager defaultManager ];
#ifdef DEBUG
      //  [ fm removeItemAtPath:pstrDatabaseFile_ error:nil ];
#endif
    //    Log( @"%@", pstrDatabaseFile_ );
        dbSQlite_ = [[ FMDatabase alloc ] initWithPath:pstrDatabaseFile_ ];
        BOOL bOpen = NO;
        if ( ![ fm fileExistsAtPath: pstrDatabaseFile_ ] )
        {
            bOpen = [ dbSQlite_ open ];
            if ( bOpen )
            {
                [ self initDateTable ];
            }
        }
        else
        {
            bOpen = [ dbSQlite_ open ];
        }
        if ( !bOpen )
        {
            [ dbSQlite_ release ];
            dbSQlite_  = nil;
            [ self release ];
            return nil;
        }
    }
    
    return self;
}

- (void)dealloc
{
    if ( dbSQlite_ )
    {
        [ dbSQlite_ close ];
        [ dbSQlite_ release ];
    }
    [ pstrDatabaseFile_ release ];
    
    [ super dealloc ];
}

//*******main itinerary
- (BOOL)insertMainItinerary:(CMainItinerary *)pMainIniterary
{
    NSString *pstrSQL = [[ NSString alloc ] initWithFormat: 
    @"insert into tb_MainItinerary( SerialNumber, timeStamp, tourGroupName, travelAgencyName, \
     memberCount, startDay, endDay, standardCost, roomCost, mealCost, trafficCost, \
     personalTotalCost, groupTotalCost, ticketCost ) \
     values('%@', '%@', '%@', '%@', %d, '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')", 
     pMainIniterary.serialNumber, pMainIniterary.timeStamp, pMainIniterary.tourGroupName, 
                         pMainIniterary.travelAgencyName,
     pMainIniterary.memberCount, pMainIniterary.startDay, pMainIniterary.endDay,
     pMainIniterary.standardCost, pMainIniterary.roomCost, pMainIniterary.mealCost,
     pMainIniterary.trafficCost, pMainIniterary.personalTotalCost, 
     pMainIniterary.groupTotalCost, pMainIniterary.ticketCost ];
    
    BOOL bRet = [ dbSQlite_ executeUpdate:pstrSQL ];
    [ pstrSQL release ];
    return bRet;
    
}

- (BOOL)getAllMainItinerarySerialNumber:(NSMutableArray*)parrMainSerialNumber
{
    BOOL bRet = NO;
    if ( nil == parrMainSerialNumber )
    {
        return bRet;
    }
    [ parrMainSerialNumber removeAllObjects ];
    
    NSString *pstrSQL = [[ NSString alloc ] initWithString:
                         @"select SerialNumber, startDay, tourGroupName from tb_MainItinerary" ];
    
    CMainItinerarySerialNumner *pMainItinerarySerialNumner = NULL;
    
    FMResultSet *record = [ dbSQlite_ executeQuery:pstrSQL ];
    while ( [ record next ] )
    {
        pMainItinerarySerialNumner = [[ CMainItinerarySerialNumner alloc ] init ];
        pMainItinerarySerialNumner.date = [ record stringForColumn:@"startDay" ];
        pMainItinerarySerialNumner.serialNumner = [ record stringForColumn:@"serialNumber" ];
        pMainItinerarySerialNumner.groupName = [ record stringForColumn:@"tourGroupName" ];
        [ parrMainSerialNumber addObject: pMainItinerarySerialNumner ];
        [ pMainItinerarySerialNumner release ];
    }
  
    [ pstrSQL release ];
    
    return YES;
}

- (BOOL)deleteItineraryBySerialNumber:(NSString *)pstrSerialNumber
{
    NSString *pstrSQL = [[ NSString alloc ] initWithFormat:
                         @"delete from tb_MainItinerary where SerialNumber = '%@'",
                         pstrSerialNumber ];
    [ dbSQlite_ executeUpdate:pstrSQL ];
    [ pstrSQL release ];
    
    pstrSQL = [[ NSString alloc ] initWithFormat:
                         @"delete from tb_DetailItinerary where SerialNumber = '%@'",
                         pstrSerialNumber ];
    [ dbSQlite_ executeUpdate:pstrSQL ];
    [ pstrSQL release ];
    

    return YES;    
     
}

//*********detail itinerary
- (BOOL)insertDetailItinerary:(CDetailItinerary *)pDetailItinerary
{
    
    NSString *pstrSQL = [[ NSString alloc ] initWithFormat: 
                         @"insert into tb_DetailItinerary( nindex, serialNumber, day, \
                         traffic, trafficNo, driverName, driverPhone, city, meal, room, \
                         detailDesc, localTravelAgencyName, localGuide, localGuidePhone ) \
                         values(%u, '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')", 
                         pDetailItinerary.index, pDetailItinerary.serialNumber, pDetailItinerary.day,
                         pDetailItinerary.traffic, pDetailItinerary.trafficNo, pDetailItinerary.driverName,
                         pDetailItinerary.driverPhone, pDetailItinerary.city, pDetailItinerary.meal,
                         pDetailItinerary.room, pDetailItinerary.detailDesc, 
                         pDetailItinerary.localTravelAgencyName, pDetailItinerary.localGuide,
                         pDetailItinerary.localGuidePhone ];
        
    BOOL bRet = [ dbSQlite_ executeUpdate:pstrSQL ];
    [ pstrSQL release ];
    return bRet;

}

- (BOOL)getAllDetailItinerary:(NSMutableArray*)parrDetail ByMainSerialNumber:( NSString *)pstrMainSerialNumber;
{
    BOOL bRet = NO;
    if ( nil == parrDetail ) 
    {
        return bRet;
    }
    [ parrDetail removeAllObjects ];
    
    NSString *pstrSQL = [[ NSString alloc ] initWithFormat:
                         @"select * from tb_DetailItinerary where serialNumber = '%@'", pstrMainSerialNumber ];
    CDetailItinerary *pDetailItinerary = NULL;
    
//    @"create table tb_DetailItinerary \
//    ( id INTEGER PRIMARY KEY AUTOINCREMENT, \
//    nindex INTEGER, \
//    serialNumber TEXT, \
//    day TEXT, \
//    traffic TEXT, \
//    trafficNo TEXT, \
//    driverName INTEGER, \
//    driverPhone TEXT, \
//    city TEXT, \
//    meal TEXT, \
//    room TEXT, \
//    detailDesc TEXT, \
//    localTravelAgencyName TEXT, \
//    localGuide TEXT, \
//    localGuidePhone TEXT )"
    
    FMResultSet *record = [ dbSQlite_ executeQuery:pstrSQL ];
    while ( [ record next ] )
    {
        pDetailItinerary = [[ CDetailItinerary alloc ] init ];
        pDetailItinerary.uid = (uint32_t)[ record intForColumn:@"id" ];
        pDetailItinerary.index = [ record intForColumn:@"nindex" ];
        pDetailItinerary.serialNumber = [ record stringForColumn:@"serialNumber"];
        pDetailItinerary.day = [ record stringForColumn:@"day"];;
        pDetailItinerary.traffic = [ record stringForColumn:@"traffic"];;
        pDetailItinerary.trafficNo = [ record stringForColumn:@"trafficNo"];;
        pDetailItinerary.driverName = [ record stringForColumn:@"driverName"];;
        pDetailItinerary.driverPhone = [ record stringForColumn:@"driverPhone"];;
        pDetailItinerary.city = [ record stringForColumn:@"city"];;
        pDetailItinerary.meal = [ record stringForColumn:@"meal"];;
        pDetailItinerary.room = [ record stringForColumn:@"room"];;
        pDetailItinerary.detailDesc = [ record stringForColumn:@"detailDesc"];;
        pDetailItinerary.localTravelAgencyName = [ record stringForColumn:@"localTravelAgencyName"];;
        pDetailItinerary.localGuide = [ record stringForColumn:@"localGuide"];;
        pDetailItinerary.localGuidePhone = [ record stringForColumn:@"localGuidePhone"];;
        
        [ parrDetail addObject: pDetailItinerary ];
        [ pDetailItinerary release ];

    }
   
    return YES;
}


//**************group member
- (BOOL)insertGroupMember:(CGroupMember *)pGroupMember
{
    NSString *pstrSQL = [[ NSString alloc ] initWithFormat: 
                         @"insert into tb_GroupMember( paid, serialNumber, \
                         name, sex, age, remark, phone, idCardType, \
                         idCardNumber ) values( %d, '%@', '%@', '%@', '%@', '%@', \
                         '%@', '%@', '%@' )", 
                         pGroupMember.paid, pGroupMember.serialNumber, pGroupMember.name,
                         pGroupMember.sex, pGroupMember.age, pGroupMember.remark,
                         pGroupMember.phone, pGroupMember.idCardType, pGroupMember.idCardNumber ];
    
    BOOL bRet = [ dbSQlite_ executeUpdate:pstrSQL ];
    [ pstrSQL release ];
    return bRet;

}

- (BOOL)deleteGroupMemberInfoByBySerialNumber:(NSString *)pstrSerialNumber
{
    NSString *pstrSQL = [[ NSString alloc ] initWithFormat:
               @"delete from tb_GroupMember where SerialNumber = '%@'",
               pstrSerialNumber ];
    [ dbSQlite_ executeUpdate:pstrSQL ];
    [ pstrSQL release ];
    return YES;
}

- (BOOL)getAllGroupMember:(NSMutableArray*)parrGroupMember ByMainSerialNumber:( NSString *)pstrMainSerialNumber;
{
    BOOL bRet = NO;
    if ( nil == parrGroupMember )
    {
        return bRet;
    }
    [ parrGroupMember removeAllObjects ];
  //  NSString *pstrSQL = [[ NSString alloc ] initWithFormat:
  //                       @"select * from tb_DetailItinerary where serialNumber = '%@'", pstrMainSerialNumber ];
    NSString *pstrSQL = [[ NSString alloc ] initWithString:
                         @"select * from tb_GroupMember" ];

//    ( id INTEGER PRIMARY KEY AUTOINCREMENT, \
//     paid INTEGER, \
//     serialNumber TEXT, \
//     name TEXT, \
//     sex TEXT, \
//     age TEXT, \
//     remark INTEGER, \
//     phone TEXT, \
//     idCardType TEXT, \
//     idCardNumber TEXT )"];

    CGroupMember *pGroupMember = nil;
    FMResultSet *record = [ dbSQlite_ executeQuery:pstrSQL ];
    while ( [ record next ] )
    {
        pGroupMember = [[ CGroupMember alloc ] init ];
        pGroupMember.uid = (uint32_t)[ record intForColumn:@"id" ];
        pGroupMember.paid = [ record intForColumn:@"paid" ];
        pGroupMember.serialNumber = [ record stringForColumn:@"serialNumber" ];
        pGroupMember.name = [ record stringForColumn:@"name" ];
        pGroupMember.sex = [ record stringForColumn:@"sex" ];
        pGroupMember.age = [ record stringForColumn:@"age" ];
        pGroupMember.remark = [ record stringForColumn:@"remark" ];
        pGroupMember.phone = [ record stringForColumn:@"phone" ];
        pGroupMember.idCardType = [ record stringForColumn:@"idCardType" ];
        pGroupMember.idCardNumber = [ record stringForColumn:@"idCardNumber" ];
        
        [ parrGroupMember addObject: pGroupMember ];
        [ pGroupMember release ];

    }
    
    
    return YES;
}



- (void)initDateTable
{
    NSString *strTableMain = [[ NSString alloc ] initWithFormat:@"create table tb_MainItinerary \
    ( id INTEGER PRIMARY KEY AUTOINCREMENT, \
    SerialNumber TEXT, \
    timeStamp TEXT, \
    tourGroupName TEXT, \
    travelAgencyName TEXT, \
    memberCount INTEGER, \
    startDay TEXT, \
    endDay TEXT, \
    standardCost TEXT, \
    roomCost TEXT, \
    mealCost TEXT, \
    trafficCost TEXT, \
    personalTotalCost TEXT, \
    groupTotalCost TEXT, \
    ticketCost TEXT )" ];
    [ dbSQlite_ executeUpdate: strTableMain ];
    [ strTableMain release ];
    
    NSString *strTableDetail = [[ NSString alloc ] initWithFormat:@"create table tb_DetailItinerary \
    ( id INTEGER PRIMARY KEY AUTOINCREMENT, \
    nindex INTEGER, \
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
    localGuidePhone TEXT )"];
    [ dbSQlite_ executeUpdate: strTableDetail ];
    [ strTableDetail release ];
    
    
    NSString *strTableGroup = [[ NSString alloc ] initWithFormat:@"create table tb_GroupMember \
    ( id INTEGER PRIMARY KEY AUTOINCREMENT, \
    paid INTEGER, \
    serialNumber TEXT, \
    name TEXT, \
    sex TEXT, \
    age TEXT, \
    remark INTEGER, \
    phone TEXT, \
    idCardType TEXT, \
    idCardNumber TEXT )"];
    [ dbSQlite_ executeUpdate: strTableGroup ];
    [ strTableGroup release ];
}


@end

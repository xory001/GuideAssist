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


- (BOOL)initDatabase
{
    char *pstrCreateMainItineraryTable = 
    "create table tb MainItinerary \
    ( id INTEGER PRIMARY KEY AUTOINCREMENT, \
    TimeStamp TEXT, \
    TourGroupName TEXT, \
    TravelAgencyName TEXT, \
    MemberCount INTEGER, \
    StatDay TEXT, \
    EndDay TEXT, \
    StandardCost TEXT, \
    RoomCost TEXT, \
    MealCost TEXT, \
    TrafficCost TEXT, \
    PersonalTotalCost TEXT, \
    GroupTotalCost TEXT, \
    TicketCost TEXT )";
    
    [ self executeSQL:pstrCreateMainItineraryTable ];
    
    return TRUE;
                        
}

- (BOOL)executeSQL:(char*)pszSQL
{
    char *pszErrString = NULL;
    sqlite3_exec( pSQLite3_, pszSQL, NULL, NULL, &pszErrString );
    if ( pszErrString )
    {
        NSLog( @"%s", pszErrString );
        sqlite3_free( pszErrString );
        return FALSE;
    }
    return TRUE;
}

@end

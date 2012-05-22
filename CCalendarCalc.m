//
//  CCalendarCalc.m
//  GuideAssist
//
//  Created by 朱 起伟 on 12-5-22.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CCalendarCalc.h"

/*
 enum {
 NSEraCalendarUnit = kCFCalendarUnitEra,
 NSYearCalendarUnit = kCFCalendarUnitYear,
 NSMonthCalendarUnit = kCFCalendarUnitMonth,
 NSDayCalendarUnit = kCFCalendarUnitDay,
 NSHourCalendarUnit = kCFCalendarUnitHour,
 NSMinuteCalendarUnit = kCFCalendarUnitMinute,
 NSSecondCalendarUnit = kCFCalendarUnitSecond,
 NSWeekCalendarUnit = kCFCalendarUnitWeek,
 NSWeekdayCalendarUnit = kCFCalendarUnitWeekday,
 NSWeekdayOrdinalCalendarUnit = kCFCalendarUnitWeekdayOrdinal,
 #if MAC_OS_X_VERSION_10_6 <= MAC_OS_X_VERSION_MAX_ALLOWED || __IPHONE_4_0 <= __IPHONE_OS_VERSION_MAX_ALLOWED
 NSQuarterCalendarUnit = kCFCalendarUnitQuarter,
 #endif
 #if __IPHONE_4_0 <= __IPHONE_OS_VERSION_MAX_ALLOWED
 NSCalendarCalendarUnit = (1 << 20),
 NSTimeZoneCalendarUnit = (1 << 21),
 #endif
 };
*/

@implementation CCalendarCalc

+ (NSInteger)getCurMonthFisrtDayWeek:(NSInteger*)pDaysOfMonth
{
  //  NSTimeZone *timeZone = [ NSTimeZone localTimeZone ];
    NSDate *nowDate = [ NSDate date ];
    NSCalendar *calendar = [ NSCalendar currentCalendar ];
    if ( NULL != pDaysOfMonth )
    {
        *pDaysOfMonth = [ calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit
                                forDate:nowDate ].length;
    }
    NSDateComponents *comp = [ calendar components:NSWeekdayCalendarUnit|NSWeekdayOrdinalCalendarUnit
                                          fromDate:nowDate ];
    
    return [ comp weekday ];
}

+ (NSInteger)getTheMonthFisrtDayWeek:(NSString *)strYear month:(NSString *)strMonth
{
    return 0;
}

+ (NSInteger)getDaysOfPreMonth
{
    NSDate *nowDate = [ NSDate date ];
    NSCalendar *calendar = [ NSCalendar currentCalendar ];
    NSDateComponents *comp = [[ NSDateComponents alloc ] init ];
    [ comp setMonth:-1 ];
    NSDate *preDate = [ calendar dateByAddingComponents:comp toDate:nowDate options:0 ];
    return [ calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit
                                     forDate:preDate ].length;
}

@end














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

+ (BOOL)getCurYear:(NSInteger *)pnYear andMonth:(NSInteger *)pnMonth
{
    NSDate *nowDate = [ NSDate date ];
    NSCalendar *calendar = [ NSCalendar currentCalendar ];
    NSDateComponents *comp = [ calendar components:NSYearCalendarUnit|NSMonthCalendarUnit
                                          fromDate:nowDate ];
    if ( NULL != pnYear )
    {
        *pnYear = [ comp year ];
    }
    
    if ( NULL != pnMonth )
    {
        *pnMonth = [ comp month ];
    }
    
    return YES;
}

+ (NSInteger)getFisrtDayWeekAndDaysOfMonth:(NSInteger *)pDaysOfMonth 
                                    byYear:(NSInteger)nYear andMonth:(NSInteger)nMonth
{
  //  NSString *strDate = [[ NSString alloc ] initWithFormat:@"%d-%02d-01", nYear, nMonth ];
 //   NSDate *nowDate = [ NSDate date ];
    NSCalendar *calendar = [ NSCalendar currentCalendar ];
    NSDateComponents *comp = [[ NSDateComponents alloc ] init ];
    [ comp setMonth: nMonth ];
    [ comp setYear: nYear ];
    [ comp setDay:1 ];
    [ comp setHour: 12 ];
    [ comp setMinute:30 ];
    [ comp setSecond:30 ];
   // [ comp setTimeZone:
    
    NSDate *dateAppoint = [ calendar dateFromComponents:comp ];
    if ( NULL != pDaysOfMonth )
    {
        *pDaysOfMonth = [ calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit
                                       forDate:dateAppoint ].length;
    }
    int nWeekDay = [[ calendar components:NSWeekdayCalendarUnit|NSWeekdayOrdinalCalendarUnit
                                          fromDate:dateAppoint ] weekday ];
    
    return nWeekDay;

}

+ (NSString *)getCurDay
{
    //  NSTimeZone *timeZone = [ NSTimeZone localTimeZone ];
    NSDate *nowDate = [ NSDate date ];
    NSCalendar *calendar = [ NSCalendar currentCalendar ];
    NSDateComponents *comp = [ calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
                                          fromDate:nowDate ];
    NSString *strCurDay = [ NSString stringWithFormat:@"%04d-%02d-%02d", [ comp year ], [ comp month ], [ comp day ]];
    return strCurDay;

}

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














//
//  CCalendarCalc.h
//  GuideAssist
//
//  Created by 朱 起伟 on 12-5-22.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CCalendarCalc : NSObject 
{
    
}

+ (BOOL)getCurYear:(NSInteger*)pnYear andMonth:(NSInteger*)pnMonth;
+ (NSInteger)getFisrtDayWeekAndDaysOfMonth:(NSInteger*)pDaysOfMonth 
                                    byYear:(NSInteger)nYear andMonth:(NSInteger)nMonth;


+ (NSInteger)getCurMonthFisrtDayWeek:(NSInteger*)pDaysOfMonth;
+ (NSInteger)getDaysOfPreMonth;

@end

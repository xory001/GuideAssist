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


+ (NSInteger)getCurMonthFisrtDayWeek:(NSInteger*)pDaysOfMonth;
+ (NSInteger)getTheMonthFisrtDayWeek:(NSString*)strYear month:(NSString*)strMonth;

+ (NSInteger)getDaysOfPreMonth;

@end

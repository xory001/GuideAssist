//
//  CItineraryMgr.h
//  GuideAssist
//
//  Created by 朱 起伟 on 12-5-17.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCalendarCalc.h"


@interface CItineraryMgr : UIViewController 
{
    NSMutableDictionary *dictLabel_;
    NSMutableArray *arrLabel_;
    int nCurYear_;
    int nCurMonth_;
}

- (void)labelClick:(id)sender forEvent:(UIEvent*)event;

- (void)showCalendar;

@end

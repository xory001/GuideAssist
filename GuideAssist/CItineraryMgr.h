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
    NSMutableArray *arrItineraryNumber_;
    NSMutableArray *arrLabel_;
    NSMutableArray *arrBtnHasFlag_;
    UIImage *imgLastMonth_;
    UIImage *imgCurMonth_;
    UIImage *imgNexMonth_;

    int nCurYear_;
    int nCurMonth_;
}

- (void)labelClick:(id)sender forEvent:(UIEvent*)event;

- (void)addBtnFlag:(UIButton*)btn forImage:(UIImage*)imgFlag;
- (void)showCalendar;
- (void)clearAllBtnFlag;

@end

//
//  CTodayItineraryController.h
//  GuideAssist
//
//  Created by 朱 起伟 on 12-5-13.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CTodayItineraryController : UIViewController 
{
    UIScrollView *scrollView_;
    UIButton *btnPreDay_;
    UIButton *btnNextDay_;
}
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView_;
@property (nonatomic, retain) IBOutlet UIButton *btnPreDay_;
@property (nonatomic, retain) IBOutlet UIButton *btnNextDay_;

- (IBAction)btnPreDayClick:(id)sender forEvent:(UIEvent *)event;
- (IBAction)btnNextDayClick:(id)sender forEvent:(UIEvent *)event;
- (BOOL)userInit:(NSString*)pstrItinearyNumber;

@end

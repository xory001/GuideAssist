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
    NSString *strItineraryNumber_;
    NSString *strGroupName_;
    NSMutableArray *arrDetailItinerary_;
    int nDetailIndex_;
    
    UIScrollView *scrollView_;
    UIButton *btnPreDay_;
    UIButton *btnNextDay_;
    UILabel *labelDay_;
    UILabel *labelCity_;
    UILabel *labelCount_;
    UILabel *labelGuideName_;
    UILabel *labelGuidePhone_;
    UILabel *labelTrafficType_;
    UILabel *labelDriveName_;
    UILabel *labelDrivePhone_;
    UILabel *labelItineraryDesc;
    UILabel *labelPage_;
    UILabel *labelTravelGroupName_;
}

//@property (nonatomic, copy) NSString *itineraryNumber;
//@property (nonatomic, copy) NSString *groupName;

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView_;
@property (nonatomic, retain) IBOutlet UIButton *btnPreDay_;
@property (nonatomic, retain) IBOutlet UIButton *btnNextDay_;
@property (nonatomic, retain) IBOutlet UILabel *labelDay_;
@property (nonatomic, retain) IBOutlet UILabel *labelCity_;
@property (nonatomic, retain) IBOutlet UILabel *labelCount_;
@property (nonatomic, retain) IBOutlet UILabel *labelGuideName_;
@property (nonatomic, retain) IBOutlet UILabel *labelGuidePhone_;
@property (nonatomic, retain) IBOutlet UILabel *labelTrafficType_;
@property (nonatomic, retain) IBOutlet UILabel *labelDriveName_;
@property (nonatomic, retain) IBOutlet UILabel *labelDrivePhone_;
@property (nonatomic, retain) IBOutlet UILabel *labelItineraryDesc;
@property (nonatomic, retain) IBOutlet UILabel *labelPage_;
@property (nonatomic, retain) IBOutlet UILabel *labelTravelGroupName_;

- (IBAction)btnPreDayClick:(id)sender forEvent:(UIEvent *)event;
- (IBAction)btnNextDayClick:(id)sender forEvent:(UIEvent *)event;

- (BOOL)userInit:(NSString*)pstrItinearyNumber groupName:(NSString*)strGroupName;
- (void)showItineraryDetailInfo;

@end

//
//  CGroupMemberDetailController.h
//  GuideAssist
//
//  Created by 朱 起伟 on 12-5-12.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CGroupMemberDetailController : UIViewController {
    
    UILabel *labelPage_;
    UILabel *labelSex_;
    UILabel *labelAge_;
    UILabel *labelPhone_;
    UILabel *labelIDCard_;
    UILabel *labelIDCardNo_;
    UILabel *labelPaidState_;
    UILabel *labelRemark_;
    UILabel *labelName_;
    UIButton *btnPrePage_;
    UIButton *btnNextPage_;
    
    NSArray *pArrGroupMember_;
    NSInteger nCurMemberIndex_;
}
@property (nonatomic, retain) IBOutlet UILabel *labelPage_;
@property (nonatomic, retain) IBOutlet UILabel *labelSex_;
@property (nonatomic, retain) IBOutlet UILabel *labelAge_;
@property (nonatomic, retain) IBOutlet UILabel *labelPhone_;
@property (nonatomic, retain) IBOutlet UILabel *labelIDCard_;
@property (nonatomic, retain) IBOutlet UILabel *labelIDCardNo_;
@property (nonatomic, retain) IBOutlet UILabel *labelPaidState_;
@property (nonatomic, retain) IBOutlet UILabel *labelRemark_;
@property (nonatomic, retain) IBOutlet UILabel *labelName_;
@property (nonatomic, retain) IBOutlet UIButton *btnPrePage_;
@property (nonatomic, retain) IBOutlet UIButton *btnNextPage_;

@property (nonatomic, retain) NSArray *arrGroupMember;
@property (nonatomic, assign) NSInteger nCurMemberIndex;

- (IBAction)btnPrePageClick:(id)sender forEvent:(UIEvent *)event;
- (IBAction)btnNextPageClick:(id)sender forEvent:(UIEvent *)event;

- (void)updateMemberInfo;
- (void)initViewState;



@end

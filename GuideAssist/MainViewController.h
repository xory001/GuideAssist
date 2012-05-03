//
//  MainViewController.h
//  GuideAssist
//
//  Created by 朱 起伟 on 11-8-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MainViewController : UIViewController 
{
@private
    NSDictionary *pDictMainIcon_;
    NSArray *pMainView_;
    
}

@property( nonatomic, retain ) NSDictionary *dicMainIcon;
@property( nonatomic, retain ) NSArray *mainView;

- (BOOL)initBtns;

- (void)BtnEvent:(id)sender forEvent:(UIControlEvents)event;

@end

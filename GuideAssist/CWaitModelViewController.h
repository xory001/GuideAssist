//
//  CWaitModelViewController.h
//  GuideAssist
//
//  Created by 朱 起伟 on 12-5-15.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CWaitModelViewController : UIViewController {
    
    UIActivityIndicatorView *activityIndicatorView_;
    NSString *strMessage_;
    UILabel *labelMessage_;
}
@property (nonatomic, retain) IBOutlet UILabel *labelMessage_;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property ( nonatomic, copy ) NSString *message;

- (void)start;

@end

//
//  DataType.h
//  GuideAssist
//
//  Created by 朱 起伟 on 12-4-10.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//


#import "CMainItinerary.h"
#import "CDetailItinerary.h"
#import "CGroupMember.h"


@interface CMainItineraryDateID : NSObject
{
@private
    uint32_t uid_;
    NSString *pstrDate_;
}

@property ( nonatomic, assign ) uint32_t uid;
@property ( nonatomic, retain ) NSString *date;


@end






























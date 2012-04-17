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


@interface CMainItinerarySerialNumner : NSObject
{
@private
    NSString *pstrSerialNumner_;
    NSString *pstrDate_;
}

@property ( nonatomic, copy ) NSString *serialNumner;
@property ( nonatomic, copy ) NSString *date;


@end






























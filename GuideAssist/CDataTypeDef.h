//
//  DataType.h
//  GuideAssist
//
//  Created by 朱 起伟 on 12-4-10.ITINERARY_STATE//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//


#import "CMainItinerary.h"
#import "CDetailItinerary.h"
#import "CGroupMember.h"

enum ITINERARY_STATE
{
    ITINERARY_STATE_ADD = 1,
    ITINERARY_STATE_MODIFY = 2,
    ITINERARY_STATE_DEL = 3
};


@interface CMainItinerarySerialNumner : NSObject
{
@private
    NSString *pstrSerialNumner_;
    NSString *pstrDate_;
}

@property ( nonatomic, copy ) NSString *serialNumner;
@property ( nonatomic, copy ) NSString *date;


@end






























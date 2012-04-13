//
//  CMainItinerary.h
//  GuideAssist
//
//  Created by 朱 起伟 on 12-4-11.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface  CMainItinerary  : NSObject 
{
@private
    UInt32 uid_;
    NSString *pstrTimeStamp_;
    NSString *pstrTourGroupName_;
    NSString *pstrTravelAgencyName_;
    UInt32 nMemberCount_;
    NSString *pstrStatDay_;
    NSString *pstrEndDay_;
    NSString *pstrStandardCost_;
    NSString *pstrRoomCost_;
    NSString *pstrTicketCost_;
    NSString *pstrMealCost_;
    NSString *pstrTrafficCost_;
    NSString *pstrPersonalTotalCost_;
    NSString *pstrGroupTotalCost_;    
    
}

@property( nonatomic, assign ) UInt32 uid;
@property( nonatomic, retain ) NSString *timeStamp;
@property( nonatomic, retain ) NSString *tourGroupName;
@property( nonatomic, retain ) NSString *travelAgencyName;
@property( nonatomic, assign ) UInt32 memberCount;
@property( nonatomic, retain ) NSString *statDay;
@property( nonatomic, retain ) NSString *endDay;
@property( nonatomic, retain ) NSString *standardCost;
@property( nonatomic, retain ) NSString *roomCost;
@property( nonatomic, retain ) NSString *mealCost;
@property( nonatomic, retain ) NSString *trafficCost;
@property( nonatomic, retain ) NSString *personalTotalCost;
@property( nonatomic, retain ) NSString *groupTotalCost;
@property( nonatomic, retain ) NSString *ticketCost;


@end

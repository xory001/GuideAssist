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
    UInt32 nid_;
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

@property( nonatomic, assign ) UInt32 nid;
@property( nonatomic, retain ) NSString *TimeStamp;
@property( nonatomic, retain ) NSString *TourGroupName;
@property( nonatomic, retain ) NSString *TravelAgencyName;
@property( nonatomic, assign ) UInt32 MemberCount;
@property( nonatomic, retain ) NSString *StatDay;
@property( nonatomic, retain ) NSString *EndDay;
@property( nonatomic, retain ) NSString *StandardCost;
@property( nonatomic, retain ) NSString *RoomCost;
@property( nonatomic, retain ) NSString *MealCost;
@property( nonatomic, retain ) NSString *TrafficCost;
@property( nonatomic, retain ) NSString *PersonalTotalCost;
@property( nonatomic, retain ) NSString *GroupTotalCost;
@property( nonatomic, retain ) NSString *TicketCost;


@end

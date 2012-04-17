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
    NSString *pstrSerialNumber_;
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
@property( nonatomic, copy ) NSString *serialNumber;
@property( nonatomic, copy ) NSString *timeStamp;
@property( nonatomic, copy ) NSString *tourGroupName;
@property( nonatomic, copy ) NSString *travelAgencyName;
@property( nonatomic, assign ) UInt32 memberCount;
@property( nonatomic, copy ) NSString *statDay;
@property( nonatomic, copy ) NSString *endDay;
@property( nonatomic, copy ) NSString *standardCost;
@property( nonatomic, copy ) NSString *roomCost;
@property( nonatomic, copy ) NSString *mealCost;
@property( nonatomic, copy ) NSString *trafficCost;
@property( nonatomic, copy ) NSString *personalTotalCost;
@property( nonatomic, copy ) NSString *groupTotalCost;
@property( nonatomic, copy ) NSString *ticketCost;


@end

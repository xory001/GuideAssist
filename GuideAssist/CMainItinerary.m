//
//  CMainItinerary.m
//  GuideAssist
//
//  Created by 朱 起伟 on 12-4-11.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#include "CMainItinerary.h"

@implementation CMainItinerary

@synthesize uid = uid_;
@synthesize serialNumber = pstrSerialNumber_;
@synthesize tourGroupName = pstrTourGroupName_;
@synthesize travelAgencyName = pstrTravelAgencyName_;
@synthesize memberCount = nMemberCount_;
@synthesize timeStamp = pstrTimeStamp_;
@synthesize startDay = pstrStartDay_;
@synthesize endDay = pstrEndDay_;
@synthesize standardCost = pstrStandardCost_;
@synthesize roomCost = pstrRoomCost_;
@synthesize ticketCost = pstrTicketCost_;
@synthesize mealCost = pstrMealCost_;
@synthesize trafficCost = pstrTrafficCost_;
@synthesize personalTotalCost = pstrPersonalTotalCost_;
@synthesize groupTotalCost = pstrGroupTotalCost_;

-(id)init
{
    self = [super init];
    if ( self )
      {
        uid_ = 0;
        nMemberCount_ = 0;
        pstrSerialNumber_ = [[ NSString alloc ] init ];
        pstrTourGroupName_ = [[ NSString alloc ] init ];
        pstrTravelAgencyName_ = [[ NSString alloc ] init ];
        pstrTimeStamp_ = [[ NSString alloc ] init ];
        pstrStartDay_ = [[ NSString alloc ] init ];
        pstrEndDay_ = [[ NSString alloc ] init ];
        pstrStandardCost_ = [[ NSString alloc ] init ];
        pstrTicketCost_ = [[ NSString alloc ] init ];
        pstrMealCost_ = [[ NSString alloc ] init ];
        pstrTrafficCost_ = [[ NSString alloc ] init ];
        pstrPersonalTotalCost_ = [[ NSString alloc ] init ];
        pstrGroupTotalCost_ = [[ NSString alloc ] init ]; 
        pstrRoomCost_ = [[ NSString alloc ] init ];
      }
    return self;
    
}

-(void)dealloc
{
    self.serialNumber = nil;
    self.tourGroupName = nil;
    self.travelAgencyName = nil;
    self.timeStamp = nil;
    self.startDay = nil;
    self.endDay = nil;
    self.roomCost = nil;
    self.mealCost = nil;
    self.trafficCost = nil;
    self.personalTotalCost = nil;
    self.groupTotalCost = nil;
    self.standardCost = nil;
    self.ticketCost = nil;
    [ super dealloc ];
}

@end

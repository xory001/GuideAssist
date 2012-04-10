//
//  File.c
//  GuideAssist
//
//  Created by 朱 起伟 on 12-4-10.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#include "CDataTypeDef.h"

@implementation CMainItinerary

@synthesize nid = nid_;
@synthesize TourGroupName = pstrTourGroupName_;
@synthesize TravelAgencyName = pstrTravelAgencyName_;
@synthesize MemberCount = nMemberCount_;
@synthesize TimeStamp = pstrTimeStamp_;
@synthesize StatDay = pstrStatDay_;
@synthesize EndDay = pstrEndDay_;
@synthesize StandardCost = pstrStandardCost_;
@synthesize RoomCost = pstrRoomCost_;
@synthesize TicketCost = pstrTicketCost_;
@synthesize MealCost = pstrMealCost_;
@synthesize TrafficCost = pstrTrafficCost_;
@synthesize PersonalTotalCost = pstrPersonalTotalCost_;
@synthesize GroupTotalCost = pstrGroupTotalCost_;

-(id)init
{
    self = [super init];
    if ( self )
    {
      nid_ = 0;
      nMemberCount_ = 0;
      pstrTourGroupName_ = [[ NSString alloc ] init ];
      pstrTravelAgencyName_ = [[ NSString alloc ] init ];
      pstrTimeStamp_ = [[ NSString alloc ] init ];
      pstrStatDay_ = [[ NSString alloc ] init ];
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
    self.TourGroupName = nil;
    self.TravelAgencyName = nil;
    self.TimeStamp = nil;
    self.StatDay = nil;
    self.EndDay = nil;
    self.RoomCost = nil;
    self.MealCost = nil;
    self.TrafficCost = nil;
    self.PersonalTotalCost = nil;
    self.GroupTotalCost = nil;
    self.StandardCost = nil;
    self.TicketCost = nil;
    [ super dealloc ];
}

@end
//
//  CDetailItinerary.m
//  GuideAssist
//
//  Created by 朱 起伟 on 12-4-10.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CDetailItinerary.h"


@implementation CDetailItinerary

@synthesize nid = nid_;
@synthesize nMainid = nMainid_;
@synthesize nIndex = nIndex_;
@synthesize Day = pstrDay_;
@synthesize Traffic = pstrTraffic_;
@synthesize TrafficNo = pstrTrafficNo_;
@synthesize DriverName = pstrDriverName_;
@synthesize DriverPhone = pstrDriverPhone_;
@synthesize City = pstrCity_;
@synthesize Meal = pstrMeal_;
@synthesize Room = pstrRoom_;
@synthesize DetailDesc = pstrDetailDesc_;
@synthesize LocalTravelAgencyName = pstrLocalTravelAgencyName_;
@synthesize LocalGuide = pstrLocalGuide_;
@synthesize LocalGuidePhone = pstrLocalGuidePhone_;

- (id)init
{
    self = [ super init ];
    if ( self ) 
    {
      nid_ = 0;
      nMainid_ = 0;
      nIndex_ = 0;
      pstrDay_ = [[ NSString alloc ] init ];
      pstrTraffic_ = [[ NSString alloc ] init ];
      pstrTrafficNo_ = [[ NSString alloc ] init ];
      pstrDriverName_ = [[ NSString alloc ] init ];
      pstrDriverPhone_ = [[ NSString alloc ] init ];
      pstrCity_ = [[ NSString alloc ] init ];
      pstrMeal_ = [[ NSString alloc ] init ];
      pstrRoom_ = [[ NSString alloc ] init ];
      pstrDetailDesc_ = [[ NSString alloc ] init ];
      pstrLocalTravelAgencyName_ = [[ NSString alloc ] init ]; 
      pstrLocalGuide_ = [[ NSString alloc ] init ];
      pstrLocalGuidePhone_ = [[ NSString alloc ] init ];
    }
    return self;
}

- (void) dealloc
{
    self.Day = nil;
    self.Traffic = nil;
    self.TrafficNo = nil;
    self.DriverName = nil;
    self.DriverPhone = nil;
    self.City = nil;
    self.Meal = nil;
    self.Room = nil;
    self.DetailDesc = nil;
    self.LocalTravelAgencyName = nil;
    self.LocalGuide = nil;
    self.LocalGuidePhone = nil;
    [ super dealloc ];
}

@end

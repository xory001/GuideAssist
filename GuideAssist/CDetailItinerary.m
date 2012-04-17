//
//  CDetailItinerary.m
//  GuideAssist
//
//  Created by 朱 起伟 on 12-4-10.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CDetailItinerary.h"


@implementation CDetailItinerary

@synthesize uid = uid_;
@synthesize serialNumber = pstrSerialNumber_;
@synthesize index = nIndex_;
@synthesize day = pstrDay_;
@synthesize traffic = pstrTraffic_;
@synthesize trafficNo = pstrTrafficNo_;
@synthesize driverName = pstrDriverName_;
@synthesize driverPhone = pstrDriverPhone_;
@synthesize city = pstrCity_;
@synthesize meal = pstrMeal_;
@synthesize room = pstrRoom_;
@synthesize detailDesc = pstrDetailDesc_;
@synthesize localTravelAgencyName = pstrLocalTravelAgencyName_;
@synthesize localGuide = pstrLocalGuide_;
@synthesize localGuidePhone = pstrLocalGuidePhone_;

- (id)init
{
    self = [ super init ];
    if ( self ) 
    {
      uid_ = 0;
      nIndex_ = 0;
      pstrSerialNumber_ = [[ NSString alloc ] init ];
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
    self.serialNumber = nil;
    self.day = nil;
    self.traffic = nil;
    self.trafficNo = nil;
    self.driverName = nil;
    self.driverPhone = nil;
    self.city = nil;
    self.meal = nil;
    self.room = nil;
    self.detailDesc = nil;
    self.localTravelAgencyName = nil;
    self.localGuide = nil;
    self.localGuidePhone = nil;
    [ super dealloc ];
}

@end

//
//  CDetailItinerary.h
//  GuideAssist
//
//  Created by 朱 起伟 on 12-4-10.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CDetailItinerary : NSObject
{
@private //15 member variable
    UInt32 uid_;
    UInt32 uMainid_;
    UInt32 uIndex_;
    NSString *pstrDay_;
    NSString *pstrTraffic_;
    NSString *pstrTrafficNo_;
    NSString *pstrDriverName_;
    NSString *pstrDriverPhone_;
    NSString *pstrCity_;
    NSString *pstrMeal_;
    NSString *pstrRoom_;
    NSString *pstrDetailDesc_;
    NSString *pstrLocalTravelAgencyName_;
    NSString *pstrLocalGuide_;
    NSString *pstrLocalGuidePhone_;
    
}

@property( nonatomic, assign ) UInt32 uid;
@property( nonatomic, assign ) UInt32 mainid;
@property( nonatomic, assign ) UInt32 index;
@property( nonatomic, retain ) NSString *day;
@property( nonatomic, retain ) NSString *traffic;
@property( nonatomic, retain ) NSString *trafficNo;
@property( nonatomic, retain ) NSString *driverName;
@property( nonatomic, retain ) NSString *driverPhone;
@property( nonatomic, retain ) NSString *city;
@property( nonatomic, retain ) NSString *meal;
@property( nonatomic, retain ) NSString *room;
@property( nonatomic, retain ) NSString *detailDesc;
@property( nonatomic, retain ) NSString *localTravelAgencyName;
@property( nonatomic, retain ) NSString *localGuide;
@property( nonatomic, retain ) NSString *localGuidePhone;

@end
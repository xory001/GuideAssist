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
    UInt32 uIndex_;
    NSString *pstrSerialNumber_;
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
@property( nonatomic, copy ) NSString *serialNumber;
@property( nonatomic, assign ) UInt32 index;
@property( nonatomic, copy ) NSString *day;
@property( nonatomic, copy ) NSString *traffic;
@property( nonatomic, copy ) NSString *trafficNo;
@property( nonatomic, copy ) NSString *driverName;
@property( nonatomic, copy ) NSString *driverPhone;
@property( nonatomic, copy ) NSString *city;
@property( nonatomic, copy ) NSString *meal;
@property( nonatomic, copy ) NSString *room;
@property( nonatomic, copy ) NSString *detailDesc;
@property( nonatomic, copy ) NSString *localTravelAgencyName;
@property( nonatomic, copy ) NSString *localGuide;
@property( nonatomic, copy ) NSString *localGuidePhone;

@end
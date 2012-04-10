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
@private
    int64_t nid_;
    int64_t nMainid_;
    int32_t nIndex_;
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

@property( nonatomic, assign ) int64_t nid;
@property( nonatomic, assign ) int64_t nMainid;
@property( nonatomic, assign ) int32_t nIndex;
@property( nonatomic, retain ) NSString *Day;
@property( nonatomic, retain ) NSString *Traffic;
@property( nonatomic, retain ) NSString *TrafficNo;
@property( nonatomic, retain ) NSString *DriverName;
@property( nonatomic, retain ) NSString *DriverPhone;
@property( nonatomic, retain ) NSString *City;
@property( nonatomic, retain ) NSString *Meal;
@property( nonatomic, retain ) NSString *Room;
@property( nonatomic, retain ) NSString *DetailDesc;
@property( nonatomic, retain ) NSString *LocalTravelAgencyName;
@property( nonatomic, retain ) NSString *LocalGuide;
@property( nonatomic, retain ) NSString *LocalGuidePhone;

@end
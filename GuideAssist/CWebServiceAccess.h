//
//  CWebServiceAccess.h
//  GuideAssist
//
//  Created by 朱 起伟 on 12-4-18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "baseModule/HttpRequest.h"
#import "CDBAccess.h"

#define WEBSERVICE_URL @"http://60.191.115.39:8080/tvlsys/TourHelperService/tourHelper"

@interface CWebServiceAccess : NSObject 
{
    NSString *pstrURL_;
    NSString *pstrSoapAction_;
    NSString *pstrContentFormat_;
    
    NSString *pstrICCardNumber_;
    NSString *pstrGuidePhone_;
    
    CDBAccess *pDBAccess_;
    HttpRequest *phttpRequest_;
}

@property( nonatomic, copy ) NSString *url;
@property( nonatomic, copy ) NSString *soapAction;
@property( nonatomic, copy ) NSString *icCardNumber;
@property( nonatomic, copy ) NSString *guidePhone;
@property( nonatomic, retain ) CDBAccess *dbAccess;

- (uint32_t)getTickCount;
- (NSString*)getYYYYMMddhh;
- (NSString*)getMD5:(NSString*)pstrSource;
- (NSString*)callMethod:(NSString*)pstrRequestBody; //return xml info

- (BOOL)userLogin:(NSString**)ppstrRetErrInfo;
- (BOOL)syncItineraryInfo:(NSMutableDictionary*)pDictSyncItineraryInfo;

//if get itinerary succeed, delete the local datebase itinerary info before add
- (BOOL)getItineraryInfo:(NSString*)pstrItineraryNumber timeStamp:(NSString*)pstrTimeStamp;
- (BOOL)getGroupMember:(NSString*)pstrItineraryNumber timeStamp:(NSString*)pstrTimeStamp;
- (BOOL)closeItinerary:(NSString*)pstrItineraryNumber remark:(NSString*)pstrRemark;

@end

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

- (NSString*)getYYYYMMddhh;
- (NSString*)getMD5:(NSString*)pstrSource;
- (NSString*)callMethod:(NSString*)pstrRequestBody; //return xml info

- (BOOL)userLogin:(NSString**)ppstrRetErrInfo;
- (BOOL)syncItineraryInfo:(NSMutableDictionary*)pDictSyncItineraryInfo;

//bAdd YES add; NO modify, it is need to delete by add
- (BOOL)getItineraryInfo:(NSString*)pstrItineraryNumber timeStamp:(NSString*)pstrTimeStamp opetation:(BOOL)bUpdate; 
- (BOOL)getGroupMember:(NSMutableString*)pstrRetXML byItineraryNumber:(NSString*)pstrItineraryNumber;

@end

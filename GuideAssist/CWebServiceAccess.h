//
//  CWebServiceAccess.h
//  GuideAssist
//
//  Created by 朱 起伟 on 12-4-18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "baseModule/HttpRequest.h"


@interface CWebServiceAccess : NSObject 
{
    NSString *pstrURL_;
    NSString *pstrSoapAction_;
    NSString *pstrContentFormat_;
    
    NSString *pstrICCardNumber_;
    NSString *pstrGuidePhone_;
    
    HttpRequest *phttpRequest_;
}

@property( nonatomic, copy ) NSString *url;
@property( nonatomic, copy ) NSString *soapAction;
@property( nonatomic, copy ) NSString *icCardNumber;
@property( nonatomic, copy ) NSString *guidePhone;

- (BOOL)userLogin:(NSString*)pstrRetXML soapBody:(NSString*)pstrSoapBody;
- (BOOL)isDataSync;


@end

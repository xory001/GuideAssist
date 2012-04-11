//
//  CGroupMember.h
//  GuideAssist
//
//  Created by 朱 起伟 on 12-4-11.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CGroupMember : NSObject
{
    UInt32 nid_;
    NSString *pstrName_;
    NSString *pstrSex_;
    NSString *pstrAge_;
    NSString *pstrPhone_;
    NSString *pstrRemark_;
    int32_t  nPaid_;
    NSString *pstrIDCardType_;
    NSString *pstrIDCardNumber_;
}

@property( nonatomic, assign ) UInt32 nid;
@property( nonatomic, assign ) int32_t nPaid;
@property( nonatomic, retain ) NSString *Name;
@property( nonatomic, retain ) NSString *Sex;
@property( nonatomic, retain ) NSString *Age;
@property( nonatomic, retain ) NSString *Remark;
@property( nonatomic, retain ) NSString *Phone;
@property( nonatomic, retain ) NSString *IDCardType;
@property( nonatomic, retain ) NSString *IDCardNumber;

@end

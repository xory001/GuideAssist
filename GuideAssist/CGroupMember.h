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
    UInt32 uid_;
    NSString *pstrName_;
    NSString *pstrSex_;
    NSString *pstrAge_;
    NSString *pstrPhone_;
    NSString *pstrRemark_;
    int32_t  nPaid_;
    NSString *pstrIDCardType_;
    NSString *pstrIDCardNumber_;
}

@property( nonatomic, assign ) UInt32 uid;
@property( nonatomic, assign ) int32_t nPaid;
@property( nonatomic, retain ) NSString *name;
@property( nonatomic, retain ) NSString *sex;
@property( nonatomic, retain ) NSString *age;
@property( nonatomic, retain ) NSString *remark;
@property( nonatomic, retain ) NSString *phone;
@property( nonatomic, retain ) NSString *idCardType;
@property( nonatomic, retain ) NSString *idCardNumber;

@end

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
    NSString *pstrSerialNumber_;
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
@property( nonatomic, assign ) int32_t paid;
@property( nonatomic, copy ) NSString *serialNumber;
@property( nonatomic, copy ) NSString *name;
@property( nonatomic, copy ) NSString *sex;
@property( nonatomic, copy ) NSString *age;
@property( nonatomic, copy ) NSString *remark;
@property( nonatomic, copy ) NSString *phone;
@property( nonatomic, copy ) NSString *idCardType;
@property( nonatomic, copy ) NSString *idCardNumber;

@end

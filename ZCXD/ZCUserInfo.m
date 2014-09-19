//
//  ZCUserInfo.m
//  ZCXD
//
//  Created by JackWee on 14-8-21.
//  Copyright (c) 2014年 JackWee. All rights reserved.
//

#import "ZCUserInfo.h"

@implementation ZCUserInfo

- (instancetype)initWithName:(NSString *)name identifyID:(NSString *)identifyID telephoneNum:(NSString *)telephoneNum carNum:(NSString *)carNum handcarNum:(NSString *)handcarNum carType:(NSString *)carType carLength:(NSString *)carLength maxWeight:(NSString *)maxWeight password:(NSString *)password{
    self.name = name;
    self.identifyID = identifyID;
    self.telephoneNum = telephoneNum;
    self.carNum = carNum;
    self.handcarNum = handcarNum;
    self.carType = carType;
    self.carLength = carLength;
    self.maxWeight = maxWeight;
    return self;
}

@end

//
//  ZCUserInfo.h
//  ZCXD
//
//  Created by JackWee on 14-8-21.
//  Copyright (c) 2014年 JackWee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCUserInfo : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *identifyID;
@property (nonatomic,strong) NSString *telephoneNum;
@property (nonatomic,strong) NSString *carNum;
@property (nonatomic,strong) NSString *handcarNum;
@property (nonatomic,strong) NSString *carType;
@property (nonatomic,strong) NSString *carLength;
@property (nonatomic,strong) NSString *maxWeight;
@property (nonatomic,strong) NSString *password;

- (instancetype)initWithName:(NSString *)name identifyID:(NSString *)identifyID telephoneNum:(NSString *)telephoneNum carNum:(NSString *)carNum handcarNum:(NSString *)handcarNum carType:(NSString *)carType carLength:(NSString *)carLength maxWeight:(NSString *)maxWeight password:(NSString *)password;
@end



/*
 dr_name = forms.CharField(label='姓名：')
 dr_iden =  forms.CharField(label='身份证号码：')
 dr_tel = forms.CharField(label='手机号码：')
 dr_number = forms.CharField(label='车牌号码：')
 dr_hand = forms.CharField(label='挂车号码：')
 dr_type = forms.CharField(label='车辆类型：')
 dr_length = forms.CharField(label='车辆长度：')
 dr_weight = forms.CharField(label='最大载重：')
 dr_pwd = forms.CharField(label='设置密码：')
*/
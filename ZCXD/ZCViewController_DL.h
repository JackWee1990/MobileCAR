//
//  ZCViewController_DL.h
//  ZCXD
//
//  Created by JackWee on 14-8-8.
//  Copyright (c) 2014年 JackWee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpController.h"
#import "ZCViewController_Root.h"
@interface ZCViewController_DL : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *text_zh;
@property (strong, nonatomic) IBOutlet UITextField *text_mm;

@property (strong, nonatomic) IBOutlet UILabel *label_attention;

@property (strong, nonatomic) IBOutlet UIButton *button_zc;
@property (strong, nonatomic) IBOutlet UIButton *button_dl;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tap_space;
@property (nonatomic) BOOL isLogin;
@property (nonatomic) BOOL currentDevis3_5Inch;//判断是否为3.5inch
@property (nonatomic,strong) NSDictionary *infoDic;//存放JSON解析后［data］的信息
- (IBAction)button_zx_Click:(id)sender;
- (IBAction)button_dl_Click:(id)sender;
- (void)titleConfig;
- (void)textFieldConfig;
- (void)buttonConfig;

- (void)textFieldZHConfig;
- (void)textFieldMMConfig;
- (void)labelAttentionConfig;
- (void)fillBasicInfoWithDic:(NSDictionary*)dataDic;
- (IBAction)tap_space_Click:(id)sender;

- (IBAction)backgroundTap:(id)sender;//收键盘
- (void)userDefaultConfig;
@end

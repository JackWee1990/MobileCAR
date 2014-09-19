//
//  ZCViewController_DDXQ.h
//  ZCXD
//
//  Created by JackWee on 14-8-9.
//  Copyright (c) 2014年 JackWee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpController.h"
#import "ZCViewController_Root.h"
#import "ZCViewController_PJ.h"
@interface ZCViewController_DDXQ : UIViewController
@property (strong, nonatomic) IBOutlet UITextView *text_Info;
@property (strong, nonatomic) IBOutlet UITextView *text_introduce;
@property (strong, nonatomic) IBOutlet UITextField *text_zcdd;
@property (strong, nonatomic) IBOutlet UITextField *text_xcdd;
@property (strong, nonatomic) IBOutlet UITextField *text_dhsj;
@property (strong, nonatomic) IBOutlet UITextField *text_ddsj;
@property (strong, nonatomic) IBOutlet UITextField *text_hpmc;
@property (strong, nonatomic) IBOutlet UITextField *text_hb;
@property (strong, nonatomic) IBOutlet UITextField *text_sl;
@property (strong, nonatomic) IBOutlet UITextField *text_zzl;
@property (strong, nonatomic) IBOutlet UITextField *text_bj;
@property (strong, nonatomic) IBOutlet UIButton *button_xd;
@property (nonatomic,assign) NSString *currentOrderID;//从Root传递过来的or_id,根据其GET/POST数据
@property (nonatomic,strong) NSString *dr_tel;//从Root传递过来的dr_tel,根据其POST数据
@property (nonatomic,assign) double longitude;//从Root传递过来的longitude,根据其POST数据
@property (nonatomic,assign) double latitude;//从Root传递过来的latitude,根据其POST数据
@property (nonatomic,strong) NSDictionary *infoDic;//存放Get回来的数据
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tap_clear;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *label_red;
@property (strong, nonatomic) IBOutlet UILabel *label_xxxx;
@property (strong, nonatomic) IBOutlet UILabel *label_info;
@property (nonatomic) BOOL currentDevis3_5Inch;//判断是否为3.5inch


- (IBAction)button_xd_Click:(id)sender;
- (void)titleViewConfig;
- (void)textInfoConfig;
- (void)textIntroduceConfig;
- (void)textZCDDConfig;
- (void)textXCDDConfig;
- (void)textDHSJConfig;
- (void)textDDSJConfig;
- (void)textHPMCConfig;
- (void)textHBConfig;
- (void)textSLConfig;
- (void)textZZLConfig;
- (void)textBJConfig;
- (void)getData;
- (IBAction)tap_clear_Click:(id)sender;
- (void)scrollConfig;
- (void)submitConfig;

@end

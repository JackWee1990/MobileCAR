//
//  ZCViewController_ZC_CLXX.h
//  ZCXD
//
//  Created by JackWee on 14-8-8.
//  Copyright (c) 2014年 JackWee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCUserInfo.h"
//#import "ZCViewController_ZC_GRXX.h"
#import "ZCViewController_DL.h"
#import "HttpController.h"
@interface ZCViewController_ZC_CLXX : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITextField *text_cphm;
@property (strong, nonatomic) IBOutlet UITextField *text_gchm;
@property (strong, nonatomic) IBOutlet UITextField *text_cllx;
@property (strong, nonatomic) IBOutlet UITextField *text_clcd;
@property (strong, nonatomic) IBOutlet UITextField *text_zdzc;
@property (strong, nonatomic) IBOutlet UIButton *button_submit;
@property (strong,nonatomic) ZCUserInfo *userInfo;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tap_space;
@property (strong, nonatomic) IBOutlet UIButton *button_showtv;
@property (strong, nonatomic) IBOutlet UITableView *tv;
@property (strong,nonatomic) NSArray *truckTypeArray;

- (IBAction)button_submit_Click:(id)sender;
- (IBAction)button_showtv_Click:(id)sender;
- (void)submitInfoToServer;
- (void)titleViewConfig;
- (void)textCarNumConfig;
- (void)textHandCarNumConfig;
- (void)textCarTypeConfig;
- (void)textCarLengthConfig;
- (void)textMaxWeightConfig;
- (IBAction)tap_space_Click:(id)sender;
- (void)tvConfig;
- (void)getTruckTypeFromServer;
@end

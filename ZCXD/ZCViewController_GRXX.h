//
//  ZCViewController_GRXX.h
//  ZCXD
//
//  Created by JackWee on 14-8-9.
//  Copyright (c) 2014年 JackWee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpController.h"
#import "ZCViewController_Root.h"
@interface ZCViewController_GRXX : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *text_sjhm;
@property (strong, nonatomic) IBOutlet UITextField *text_xm;
@property (strong, nonatomic) IBOutlet UITextField *text_sfzhm;
@property (strong, nonatomic) IBOutlet UITextField *text_mm;
@property (strong, nonatomic) IBOutlet UITextField *text_qrmm;
@property (strong, nonatomic) IBOutlet UIButton *button_save;
@property (nonatomic,strong) NSMutableDictionary *infoDic;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tap_clear;

- (IBAction)button_save_Click:(id)sender;
- (void)textNameConfig;
- (void)texPhoneNumConfig;
- (void)textIDConfig;
- (void)textPWDConfig;
- (void)textPWDRConfig;
- (void)titleViewConfig;
- (IBAction)tap_clear_Click:(id)sender;


- (void)pwdUpdate;
@end

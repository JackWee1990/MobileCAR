//
//  ZCViewController_ZC_GRXX.h
//  ZCXD
//
//  Created by JackWee on 14-8-8.
//  Copyright (c) 2014年 JackWee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCUserInfo.h"
#import "ZCViewController_ZC_CLXX.h"
@interface ZCViewController_ZC_GRXX : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *text_xm;
@property (strong, nonatomic) IBOutlet UITextField *text_sjhm;
@property (strong, nonatomic) IBOutlet UITextField *text_sfz;
@property (strong, nonatomic) IBOutlet UITextField *text_mm;
@property (strong, nonatomic) IBOutlet UITextField *text_qrmm;
@property (strong, nonatomic) IBOutlet UIButton *button_next;
//@property (strong,nonatomic) ZCUserInfo *userInfo;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tap_space;

- (IBAction)button_next_Click:(id)sender;
- (void)titleViewConfig;
- (void)textNameConfig;
- (void)textPhoneNumConfig;
- (void)textIDConfig;
- (void)textPWDConfig;
- (void)textPWDRConfig;
- (IBAction)tap_space_Click:(id)sender;

@end

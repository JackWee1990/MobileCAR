//
//  ZCViewController_CLXX.h
//  ZCXD
//
//  Created by JackWee on 14-8-9.
//  Copyright (c) 2014年 JackWee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpController.h"
#import "ZCViewController_Root.h"

@interface ZCViewController_CLXX : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *text_cphm;
@property (strong, nonatomic) IBOutlet UITextField *text_gchm;
@property (strong, nonatomic) IBOutlet UITextField *text_cllx;
@property (strong, nonatomic) IBOutlet UITextField *text_clcd;
@property (strong, nonatomic) IBOutlet UITextField *text_zdzz;
@property (nonatomic,strong) NSDictionary *infoDic;
@property (strong, nonatomic) IBOutlet UIButton *button_save;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tap_clear;
@property (strong, nonatomic) IBOutlet UIButton *button_showtv;
@property (strong, nonatomic) IBOutlet UITableView *tv;

@property (strong,nonatomic) NSArray *truckTypeArray;
- (IBAction)button_save_Click:(id)sender;
- (void)textCarNumConfig;
- (void)textHandCarNumConfig;
- (void)textCarTypeConfig;
- (void)textCarLengthConfig;
- (void)textMaxWeightConfig;
- (void)titleViewConfig;
- (void)carInfoUpdate;
- (IBAction)tap_clear_Click:(id)sender;
- (IBAction)button_showtv_Click:(id)sender;
- (void)getTruckTypeFromServer;
- (void)tvConfig;
@end

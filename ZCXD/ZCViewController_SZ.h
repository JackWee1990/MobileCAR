//
//  ZCViewController_SZ.h
//  ZCXD
//
//  Created by JackWee on 14-8-9.
//  Copyright (c) 2014年 JackWee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCViewController_Root.h"
#import "ZCUIViewController_SZ_YJFK.h"
#import "ZCUIViewController_SZ_GY.h"
@interface ZCViewController_SZ : UIViewController <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property NSArray *arr;
@property (strong, nonatomic) IBOutlet UITableView *tv;
@property (strong,nonatomic) UISwitch *switchView;
@property (strong,nonatomic) UIAlertView *alertView;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)titleViewConfig;
- (void)switchAction;
@end

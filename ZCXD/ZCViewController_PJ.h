//
//  ZCViewController_PJ.h
//  ZCXD_S
//
//  Created by JackWee on 14-9-19.
//  Copyright (c) 2014年 JackWee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCViewController_PJ : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *test_pj;
@property (strong, nonatomic) IBOutlet UITableView *tv;
@property (strong,nonatomic) NSArray *arr;

- (IBAction)button_Click:(id)sender;
- (IBAction)button_pj_Click:(id)sender;

@end

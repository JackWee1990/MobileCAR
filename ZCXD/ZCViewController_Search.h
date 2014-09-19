//
//  ZCViewController_Search.h
//  ZCXD
//
//  Created by JackWee on 14-8-8.
//  Copyright (c) 2014年 JackWee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCTableViewCell_WDDD.h"
#import "ZCViewController_DDXQ.h"
#import "HttpController.h"
@interface ZCViewController_Search : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *text_source;
@property (strong, nonatomic) IBOutlet UITextField *text_dst;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *barbutton_submit;
@property (strong, nonatomic) IBOutlet UITableView *tv;
@property (nonatomic,strong) NSMutableArray *orderInfoArray;//存放Get回来的订单数据
@property (nonatomic,strong) NSArray *staticOrderInfoArray;//存放Get回来的订单数据,不可修改
@property (nonatomic,strong) NSString *dr_tel;//从Root传递过来的dr_tel,根据其Get数据
@property (nonatomic,assign) double longitude;//从Root传递过来的longitude,转传给DDXQ
@property (nonatomic,assign) double latitude;//从Root传递过来的latitude,转传给DDXQ
@property (nonatomic,assign) NSString *currentOrderID;//获取当前订单ID,转传给DDXQ
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tap_clear;
@property (nonatomic) BOOL currentDevis3_5Inch;//判断是否为3.5inch
- (IBAction)barbutton_submit_Click:(id)sender;
- (void)titleViewConfig;
- (void)textSourceConfig;
- (void)textDstConfig;
- (void)tableViewConfig;
- (IBAction)tap_clear_Click:(id)sender;
- (NSMutableArray*)loadOrderInfoArraywithSourece:(NSString*)text_Source Dst:(NSString*)text_Dst;//根据Source&Dst返回orderInfoArray
- (NSMutableArray*)loadOrderInfoArraywithSourece:(NSString*)text_Source;//根据Source返回orderInfoArray
- (NSMutableArray*)loadOrderInfoArraywithDst:(NSString*)text_Dst;//根据Source&Dst返回orderInfoArray
@end

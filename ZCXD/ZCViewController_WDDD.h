//
//  ZCViewController_WDDD.h
//  ZCXD
//
//  Created by JackWee on 14-8-9.
//  Copyright (c) 2014年 JackWee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCTableViewCell_WDDD.h"
#import "HttpController.h"
#import "ZCViewController_DDXQ.h"

@interface ZCViewController_WDDD : UIViewController <UITableViewDataSource,UITabBarDelegate,UISearchBarDelegate, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UITableView *tv;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *barbutton_qb;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *barbutton_ybj;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *barbutton_jxz;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *barbutton_ywc;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *barbutton_ygb;
@property (strong, nonatomic) UISearchBar *searchbar;
@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;
@property (nonatomic,strong) NSMutableArray *orderInfoArray;//存放Get回来的订单数据
@property (nonatomic,strong) NSArray *staticOrderInfoArray;//存放Get回来的订单数据,不可修改
@property (nonatomic,strong) NSString *dr_tel;//从Root传递过来的dr_tel,根据其Get数据
@property (nonatomic,assign) double longitude;//从Root传递过来的longitude,转传给DDXQ
@property (nonatomic,assign) double latitude;//从Root传递过来的latitude,转传给DDXQ
@property (nonatomic,assign) NSString *currentOrderID;//获取当前订单ID,转传给DDXQ
@property (nonatomic) BOOL currentDevis3_5Inch;//判断是否为3.5inch
@property (nonatomic,strong) NSString *address;//当前位置

//如果被选中改变颜色
- (IBAction)barbutton_qb_Click:(id)sender;
- (IBAction)barbutton_ybj_Click:(id)sender;
- (IBAction)barbutton_jxz_Click:(id)sender;
- (IBAction)barbutton_ywc_Click:(id)sender;
- (IBAction)barbutton_ygb_Click:(id)sender;
//自定义UIBarButtonItem customView并赋予target
- (void)barButtonItemConfig;
- (void)barbuttonQBConfig;
- (void)barbuttonYBJConfig;
- (void)barbuttonJXZConfig;
- (void)barbuttonYWCConfig;
- (void)barbuttonYGBConfig;

- (void)barbutton_Click:(id)sender;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)tableViewConfig;

- (void)navigationConfig;

- (id)searchButton_Click:(UIBarButtonItem*)sender;

- (id)cancelButton_Click:(UIBarButtonItem*)sender;

- (id)backButton_Click:(UIBarButtonItem*)sender;

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;

- (void)titleViewConfig;

- (void)getOrderData;//Get数据

- (NSMutableArray*)loadOrderInfoArraywithTag:(NSInteger)tag;//根据tag返回orderInfoArray

- (BOOL)someOrderisOnGoing;//判断是否有订单进行中

- (void)sendCurrentPoistiontoServer;//发送当前位置至服务器

@end

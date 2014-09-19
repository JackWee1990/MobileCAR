//
//  ZCViewController_Root.h
//  ZCXD
//
//  Created by JackWee on 14-8-8.
//  Copyright (c) 2014年 JackWee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import "ZCUIView_Menu.h"
#import "ZCUIView_Info.h"
#import <MAMapKit/MAMapKit.h>
#import "ZCAnnotationMake.h"
#import "ZCMenuTableViewCell.h"
#import "ZCViewController_GRXX.h"
#import "ZCViewController_CLXX.h"
#import "ZCViewController_WDDD.h"
#import "ZCViewController_SZ.h"
#import "HttpController.h"
#import "ZCViewController_DDXQ.h"
#import "ZCViewController_Search.h"
#import "ZCViewController_DL.h"


@interface ZCViewController_Root : UIViewController <UITableViewDelegate,UITableViewDataSource,MAMapViewDelegate,CLLocationManagerDelegate,AMapSearchDelegate>
@property (strong, nonatomic) IBOutlet UIBarButtonItem *barbutton_menu;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *barbutton_search;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tap_map;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *tap_menu_left;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tap_info;
@property (strong, nonatomic) UITapGestureRecognizer *tap_menu;
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) UILabel *label_message;
@property ZCUIView_Menu *menu;
@property NSArray *arr;//tableview label 数组
@property NSArray *arr_logo;//tableview logo 数组
@property CLLocationManager *locationManger;
@property (nonatomic, strong) NSMutableArray *annotations;
@property ZCUIView_Info *info;
@property MAAnnotationView *maView;
@property (nonatomic,strong) NSDictionary *infoDic;//存放登录后获取的个人信息
@property (nonatomic,strong) NSArray *aroundOrderInfo;//存放Get回来的周边订单信息数组
@property (nonatomic,assign) NSString *currentOrderID;//当前点击annotation的or_id,传递给ZCViewController_DDXQ
@property (nonatomic,assign) CLLocationDegrees _longitude_;//当前longitude,传递给ZCViewController_DDXQ
@property (nonatomic,assign) CLLocationDegrees _latitude_;//当前latitude,传递给ZCViewController_DDXQ
@property (nonatomic) BOOL isLogin;//判断是否登录
@property (nonatomic) BOOL currentDevis3_5Inch;//判断是否为3.5inch
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tap_On_imagelogo_and_labelName;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tap_lableMessage;
@property (nonatomic,strong) NSString *address;//当前位置
@property (nonatomic,strong) AMapSearchAPI *search;

- (IBAction)tap_On_map:(id)sender;
- (IBAction)tap_On_info:(id)sender;
- (IBAction)tap_On_menu_left:(id)sender;
- (IBAction)barbutton_menu_Click:(id)sender;
- (IBAction)barbutton_search_Click:(id)sender;
- (IBAction)tap_On_imagelogo_and_labelName_Click:(id)sender;
- (IBAction)tap_lableMessage_Click:(id)sender;



- (void)tapConfig;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)maMapConfig;
- (void)addZCUIView_Menu;
- (void)locationMangerConfig;
- (void)annotationConfig;
- (void)label_messageConfig;
- (void)navigationBarConfig;
- (void)getAroundOrderInfo:(CLLocationCoordinate2D)coordinate;//Get周边订单信息并存放到aroundOrderInfo数组中
- (void)menuClear;//移出menu
- (void)infoClear;//移出info
- (void)pushViewControllerDL;//push登录页面
- (void)test;//调试函数
- (BOOL)is3_5Inch;//判断是否为3.5inch
- (void)imageLogoAndNameLabTapAction;
- (void)getDataFromUserDefault;//如果userDefault中isLogin值为YES，从userDefault中获取infoDic
- (void)getInfoDicFromServer;
- (void)mapSearchConfig;//初始化AMapSearchAPI *search
- (void)searchReGeocode;//地理位置逆向查询
@end



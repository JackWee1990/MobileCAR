//
//  ZCViewController_WDDD.m
//  ZCXD
//
//  Created by JackWee on 14-8-9.
//  Copyright (c) 2014年 JackWee. All rights reserved.
//

#import "ZCViewController_WDDD.h"

@interface ZCViewController_WDDD ()

@end

@implementation ZCViewController_WDDD

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self getOrderData];
    // Do any additional setup after loading the view.
    [self tableViewConfig];
    [self navigationConfig];
    [self titleViewConfig];
    [self barButtonItemConfig];
    NSLog(@"ZCViewController_WDDD_address:%@",self.address);
    [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(getOrderData) userInfo:nil repeats:true];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableViewConfig {
    UINib *nib = [UINib nibWithNibName:@"ZCTableViewCell_WDDD" bundle:nil];
    [self.tv registerNib:nib forCellReuseIdentifier:@"ZCTableViewCell_WDDD"];
    //self.tv.delegate = self;
    self.tv.delegate = self;
    self.tv.dataSource = self;
}

- (void)navigationConfig {
    self.navigationItem.title = @"我的订单";
    /*
     //搜索功能暂时隐藏
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchButton_Click:)];
     */
    //_searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 360, 20)];
    //_searchbar.hidden = true;
    //[self.view addSubview:_searchbar];

}

- (id)searchButton_Click:(UIBarButtonItem*)sender {
    _searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 230, 28)];
    _searchbar.placeholder = @"输入要搜索的内容";
    //_searchbar.showsCancelButton = YES;
    //_searchbar.showsSearchResultsButton = YES;
    _searchbar.delegate = self;
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc]initWithCustomView:_searchbar];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObject:searchButton];
    self.navigationItem.title = nil;
    self.navigationItem.titleView = nil;
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButton_Click:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButton_Click:)];
    //self.navigationItem.rightBarButtonItem
    
    self.navigationItem.leftItemsSupplementBackButton = NO;
    return self;
}

- (id)cancelButton_Click:(UIBarButtonItem*)sender {
    //self.navigationItem.title = @"我的订单";
    [self titleViewConfig];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchButton_Click:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(backButton_Click:)];
    self.navigationItem.leftItemsSupplementBackButton = YES;
    return self;
}

- (id)backButton_Click:(UIBarButtonItem*)sender {
    
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ZCViewController_Root"];
    //[self presentViewController:vc animated:true completion:nil];
    //[self dismissViewControllerAnimated:true completion:nil];
    [[self navigationController] pushViewController:vc animated:true];
    return self;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    // called when keyboard search button pressed
    //NSLog(@"1");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)barbutton_qb_Click:(id)sender {
    //NSLog(@"~~~~~~~");
    UIButton *button = (UIButton *)sender;
    
    button.selected = !button.selected;
    //button.backgroundColor = [UIColor whiteColor];
}

- (IBAction)barbutton_ybj_Click:(id)sender {
}

- (IBAction)barbutton_jxz_Click:(id)sender {
}

- (IBAction)barbutton_ywc_Click:(id)sender {
}

- (IBAction)barbutton_ygb_Click:(id)sender {
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.orderInfoArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ZCTableViewCell_WDDD"];
    //cell.textLabel.text = _arr[indexPath.row];
    ZCTableViewCell_WDDD *cell = [self.tv dequeueReusableCellWithIdentifier:@"ZCTableViewCell_WDDD" ];
    //cell.label_cpy.text = @"黑龙江私营工厂寻找货物物流合作";
    
    NSDictionary *currentRowinfo = self.orderInfoArray[indexPath.row];//存放当前row数据信息
    
    cell.label_cpy.text = [currentRowinfo objectForKey:@"or_title"];//@"黑龙江私营工厂寻找货物物流合作";
    cell.label_cpy.textColor = [UIColor redColor];
    //cell.label_cpy.adjustsFontSizeToFitWidth = YES;
    cell.label_source.text = [currentRowinfo objectForKey:@"or_start"];//@"黑龙江省哈尔滨市南岗区 革新街321-3号";
    //cell.label_source.adjustsFontSizeToFitWidth = YES;
    cell.label_dst.text = [currentRowinfo objectForKey:@"or_end"];//@"吉林省长春市上领区 鼎新三道街218号";
    //cell.label_dst.adjustsFontSizeToFitWidth = YES;
    //NSNumber *cid = [currentRowinfo objectForKey:@"or_id"];
    //self.currentOrderID = cid.intValue;
    
    
    NSNumber *or_status = [currentRowinfo objectForKey:@"or_status"];//当前订单状态
    int orderStatus = or_status.intValue;
    NSString *imageName = nil;
    //NSString *label_status_text = nil;
    //UIColor *label_status_bgc = nil;
    switch (orderStatus) {
        case 0:
            imageName = @"ybj.png";
            //label_status_text = @"已报价";
            //label_status_bgc = [UIColor blueColor];
            break;
        case 1:
            imageName = @"jxz.png";
            //label_status_text = @"进行中";
            //label_status_bgc = [UIColor greenColor];
            break;
        case 2:
            imageName = @"ywc.png";
            //label_status_text = @"已完成";
            //label_status_bgc = [UIColor orangeColor];
            break;
        case 3:
            imageName = @"ygb.png";
            //label_status_text = @"已关闭";
            //label_status_bgc = [UIColor grayColor];
            break;
        default:
            break;
    }
    //cell.label_status.text = label_status_text;
    
    //cell.label_status.textColor = [UIColor whiteColor];
    //cell.label_status.backgroundColor = label_status_bgc;
    cell.iv_zt.image = [UIImage imageNamed:imageName];
    //cell.label_cpy.font = [UIFont systemFontOfSize:14];
    //cell.label_source.font = [UIFont systemFontOfSize:14];
    //cell.label_dst.font = [UIFont systemFontOfSize:14];
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    //NSLog(@"1");
    return cell;
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCViewController_DDXQ *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ZCViewController_DDXQ"];
    vc.dr_tel = self.dr_tel;
    vc.latitude = self.latitude;
    vc.longitude = self.longitude;
    
    NSDictionary *currentRowinfo = self.orderInfoArray[indexPath.row];//存放当前row数据信息
    
    NSString *cid = [currentRowinfo objectForKey:@"or_id"];
    vc.currentOrderID = cid;
    //vc.currentOrderID = self.currentOrderID;
    vc.currentDevis3_5Inch = self.currentDevis3_5Inch;
    [self.navigationController pushViewController:vc animated:true];
}

- (void)titleViewConfig{
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"我的订单"];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = customLab;

}

- (void)barButtonItemConfig{
    
    if (self.currentDevis3_5Inch == 1) {
        //self.toolbar.bounds = CGRectMake(0, 200, 320, 44);
        //NSLog(@"ZCViewController_WDDD_barButtonItemConfig");
    } else {
        
    }
    
    [self barbuttonQBConfig];
    [self barbuttonYBJConfig];
    [self barbuttonYGBConfig];
    [self barbuttonYWCConfig];
    [self barbuttonJXZConfig];
}

- (void)barbuttonQBConfig{
    UIButton *button_qb = [UIButton buttonWithType:UIButtonTypeSystem];
    //button_qb
    button_qb.selected = YES;
    [button_qb setTitle:@"全部" forState:UIControlStateNormal];
    [button_qb setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button_qb setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [button_qb setTintColor:[UIColor clearColor]];
    button_qb.tag = 0;
    //[button_qb setTintColor:[UIColor blackColor]];
    [button_qb setFrame:CGRectMake(0, 0, 64, 30)];
    [button_qb addTarget:self action:@selector(barbutton_Click:) forControlEvents:UIControlEventTouchUpInside];
    self.barbutton_qb.customView = button_qb;
}

- (void)barbuttonYBJConfig{
    UIButton *button_ybj = [UIButton buttonWithType:UIButtonTypeSystem];
    //button_qb
    [button_ybj setTitle:@"已报价" forState:UIControlStateNormal];
    [button_ybj setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button_ybj setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [button_ybj setTintColor:[UIColor clearColor]];
    button_ybj.tag = 1;
    [button_ybj setFrame:CGRectMake(0, 0, 64, 30)];
    [button_ybj addTarget:self action:@selector(barbutton_Click:) forControlEvents:UIControlEventTouchUpInside];
    self.barbutton_ybj.customView = button_ybj;
}
- (void)barbuttonJXZConfig{
    UIButton *button_jxz = [UIButton buttonWithType:UIButtonTypeSystem];
    //button_qb
    [button_jxz setTitle:@"进行中" forState:UIControlStateNormal];
    [button_jxz setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button_jxz setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [button_jxz setTintColor:[UIColor clearColor]];
    button_jxz.tag = 2;
    [button_jxz setFrame:CGRectMake(0, 0, 64, 30)];
    [button_jxz addTarget:self action:@selector(barbutton_Click:) forControlEvents:UIControlEventTouchUpInside];
    self.barbutton_jxz.customView = button_jxz;
}
- (void)barbuttonYWCConfig{
    UIButton *button_ywc = [UIButton buttonWithType:UIButtonTypeSystem];
    //button_qb
    [button_ywc setTitle:@"已完成" forState:UIControlStateNormal];
    [button_ywc setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button_ywc setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [button_ywc setTintColor:[UIColor clearColor]];
    button_ywc.tag = 3;
    [button_ywc setFrame:CGRectMake(0, 0, 64, 30)];
    [button_ywc addTarget:self action:@selector(barbutton_Click:) forControlEvents:UIControlEventTouchUpInside];
    self.barbutton_ywc.customView = button_ywc;
}
- (void)barbuttonYGBConfig{
    UIButton *button_ygb = [UIButton buttonWithType:UIButtonTypeSystem];
    //button_qb
    [button_ygb setTitle:@"已关闭" forState:UIControlStateNormal];
    [button_ygb setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button_ygb setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [button_ygb setTintColor:[UIColor clearColor]];
    button_ygb.tag = 4;
    [button_ygb setFrame:CGRectMake(0, 0, 64, 30)];
    [button_ygb addTarget:self action:@selector(barbutton_Click:) forControlEvents:UIControlEventTouchUpInside];
    self.barbutton_ygb.customView = button_ygb;
}

- (void)barbutton_Click:(id)sender{
    UIButton *button = (UIButton *)sender;
    //[self barButtonItemConfig];
    //使未被选中的Button title 颜色为黑
    UIBarButtonItem *item = [[UIBarButtonItem alloc]init];
    for (int i = 0; i < 5; i++) {
        item = self.toolbar.items[i];
        UIButton *btton = item.customView;
        btton.selected = NO;
    }
    //button.selected = NO;
    
    switch (button.tag) {//点击时label移动,tv reload:刷新orderInfoArray内容
        case 0:
            //NSLog(@"000000");
            if (self.currentDevis3_5Inch == 1) {
                //self.toolbar.bounds = CGRectMake(0, 200, 320, 44);
                self.label.frame = CGRectMake(17, 435, 50, 2);
            } else {
                self.label.frame = CGRectMake(17, 523, 50, 2);
            }
            //self.label.frame = CGRectMake(17, 523, 50, 2);
            button.selected = YES;
            break;
        case 1:
            //NSLog(@"1000000");
            if (self.currentDevis3_5Inch == 1) {
                //self.toolbar.bounds = CGRectMake(0, 200, 320, 44);
                self.label.frame = CGRectMake(17+58, 435, 50, 2);
            } else {
                self.label.frame = CGRectMake(17+58, 523, 50, 2);
            }
            //self.label.frame = CGRectMake(17+58, 523, 50, 2);
            button.selected = YES;
            break;
        case 2:
            //NSLog(@"2000000");
            if (self.currentDevis3_5Inch == 1) {
                //self.toolbar.bounds = CGRectMake(0, 200, 320, 44);
                self.label.frame = CGRectMake(17+58+58+2, 435, 50, 2);
            } else {
                self.label.frame = CGRectMake(17+58+58+2, 523, 50, 2);
            }
            //self.label.frame = CGRectMake(17+58+58+2, 523, 50, 2);
            button.selected = YES;
            break;
        case 3:
            //NSLog(@"3000000");
            if (self.currentDevis3_5Inch == 1) {
                //self.toolbar.bounds = CGRectMake(0, 200, 320, 44);
                self.label.frame = CGRectMake(17+58+58+58+4, 435, 50, 2);
            } else {
                self.label.frame = CGRectMake(17+58+58+58+4, 523, 50, 2);
            }
            //self.label.frame = CGRectMake(17+58+58+58+4, 523, 50, 2);
            button.selected = YES;
            break;
        case 4:
            //NSLog(@"4000000");
            if (self.currentDevis3_5Inch == 1) {
                //self.toolbar.bounds = CGRectMake(0, 200, 320, 44);
                self.label.frame = CGRectMake(17+58+58+58+58+6, 435, 50, 2);
            } else {
               self.label.frame = CGRectMake(17+58+58+58+58+6, 523, 50, 2);
            }
            //self.label.frame = CGRectMake(17+58+58+58+58+6, 523, 50, 2);
            button.selected = YES;
            break;
        default:
            break;
    }
    //UIButton *button = (UIButton *)sender;
    _orderInfoArray = [self loadOrderInfoArraywithTag:(button.tag - 1)];
    [self.tv reloadData];
    //button.selected = !button.selected;
}

- (void)getOrderData{
    //NSLog(@"ZCViewController_WDDD_getOrderData");
    //GET 我的订单
    NSData *resultData = nil;
    HttpController *httpController = [[HttpController alloc]init];
    
    NSString *type = @"GET";
    //NSString *url = @"http://115.28.107.151:8082/t/app/order/?longitude=125&latitude=45";
    NSString *url = [NSString stringWithFormat:@"app/order_list/?dr_tel=%@",self.dr_tel];
    
    NSString *info = @"nil";
    
    resultData = [httpController httpHandleWithType:type url:url info:info];
    
    _orderInfoArray = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error:nil];
    _staticOrderInfoArray = _orderInfoArray;
    [self.tv reloadData];
    //NSString *resultString = [[NSString alloc]initWithData:resultData encoding:NSUTF8StringEncoding];
    //NSLog(@"%@",resultString);
    //NSLog(@"我的订单数量：%lu",(unsigned long)self.orderInfoArray.count);
    if ([self someOrderisOnGoing]) {
        [self sendCurrentPoistiontoServer];
    }
}

- (NSMutableArray*)loadOrderInfoArraywithTag:(NSInteger)tag{
    
    /*
    1.解析staticOrderInfoArray
    2.判断orderStatus——int
    3.将符合tag的元素置入resultArray中
     */
    //NSLog(@"ZCViewController_WDDD_roadOrderInfoArraywithTag_tag=%ld\n",(long)tag);
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];
    
    if (tag == -1) {
        [resultArray addObjectsFromArray:_staticOrderInfoArray];
    } else {
        for (int i = 0; i < _staticOrderInfoArray.count; i++) {
            NSDictionary *dataDic = _staticOrderInfoArray[i];
            NSString *tagString = [NSString stringWithFormat:@"%ld",(long)tag];
            //NSLog(@"ZCViewController_WDDD_roadOrderInfoArraywithTag_or_status=%@\n",[dataDic objectForKey:@"or_status"]);
            //NSLog(@"ZCViewController_WDDD_roadOrderInfoArraywithTag_tagString=%@\n",tagString);
            NSNumber *orderStatus = [dataDic objectForKey:@"or_status"];
            int or_Status = orderStatus.intValue;
            
            if (or_Status == tag) {
                //NSLog(@"ZCViewController_WDDD_roadOrderInfoArraywithTag_beforeAddobject");
                [resultArray addObject:dataDic];
                //NSLog(@"ZCViewController_WDDD_roadOrderInfoArraywithTag_afterAddobject");
            }
            /*
            if ([[dataDic objectForKey:@"or_status"] isEqualToString:tagString]) {
                NSLog(@"ZCViewController_WDDD_roadOrderInfoArraywithTag_beforeAddobject");
                [resultArray addObject:dataDic];
                NSLog(@"ZCViewController_WDDD_roadOrderInfoArraywithTag_afterAddobject");
            }*/
        }
    }
    
    //NSLog(@"ZCViewController_WDDD_roadOrderInfoArraywithTag_resultArray.count=%lu\n",(unsigned long)resultArray.count);
    //NSMutableArray *resultArray;
    return resultArray;
}

- (BOOL)someOrderisOnGoing{
    
    for (int i = 0; i < self.orderInfoArray.count; i++) {
        NSDictionary *dataDic = [self.orderInfoArray objectAtIndex:i];
        NSNumber *or_status = [dataDic objectForKey:@"or_status"];//当前订单状态
        int orderStatus = or_status.intValue;
        if (orderStatus == 1) {
            return YES;
            //NSLog(@"ZCViewController_WDDD_someOrderisOnGoing");
            //break;
        }
    }
    
    return NO;
}

- (void)sendCurrentPoistiontoServer{
    NSLog(@"ZCViewController_WDDD_sendCurrentPoistiontoServer");
    //获取“进行中”订单数组
    NSArray *orderListOnGoingArray = [self loadOrderInfoArraywithTag:1];
    NSData *resultData = nil;
    HttpController *httpController = [[HttpController alloc]init];
    
    NSString *type = @"POST";
    NSString *url = @"app/location/";
    
    NSString *tel = [[NSUserDefaults standardUserDefaults]objectForKey:@"dr_tel"];
    double latitude = self.latitude;
    double longitude = self.longitude;
    NSString *address = self.address;
    NSString *cid;
    for (int i = 0; i < orderListOnGoingArray.count; i++) {
        NSDictionary *orderListOnGoingDic = [orderListOnGoingArray objectAtIndex:i];
        cid = [orderListOnGoingDic objectForKey:@"or_id"];
        NSString *info = [NSString stringWithFormat:@"or_id=%@&dr_tel=%@&latitude=%f&longitude=%f&address=%@",cid,tel,latitude,longitude,address];
        resultData = [httpController httpHandleWithType:type url:url info:info];
        
        NSString *responseString = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
        NSLog(@"ZCViewController_WDDD_responseString:%@",responseString);
    }
    
}
@end

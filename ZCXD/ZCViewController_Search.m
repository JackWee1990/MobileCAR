//
//  ZCViewController_Search.m
//  ZCXD
//
//  Created by JackWee on 14-8-8.
//  Copyright (c) 2014年 JackWee. All rights reserved.
//

#import "ZCViewController_Search.h"

@interface ZCViewController_Search ()

@end

@implementation ZCViewController_Search

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self.view addGestureRecognizer:self.tap_clear];
    [self titleViewConfig];
    [self textSourceConfig];
    [self textDstConfig];
    [self tableViewConfig];
    //self.navigationItem.backBarButtonItem.tintColor = [UIColor whiteColor];
    //self.navigationItem.backBarButtonItem.title = @"123";
    
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"123" style:UIBarButtonItemStylePlain target:self action:nil];
    //self.navigationItem.leftItemsSupplementBackButton = YES;
    //self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:nil];
    //self.navigationController.navigationItem.backBarButtonItem.tintColor = [UIColor whiteColor];
    //self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    //[self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)titleViewConfig{
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"查找"];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = customLab;
    
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]init];
    backButton.title = @"返回";
    self.navigationItem.backBarButtonItem = backButton;
}

- (void)textSourceConfig{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 35)];
    label.text = @" 出发地 : ";
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    self.text_source.leftView = label;
    self.text_source.leftViewMode = UITextFieldViewModeAlways;
}

- (void)textDstConfig{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 35)];
    label.text = @" 目的地 : ";
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    self.text_dst.leftView = label;
    self.text_dst.leftViewMode = UITextFieldViewModeAlways;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)barbutton_submit_Click:(id)sender {
    /*
     1.获取textFiled内容
     2.根据textFiled内容向orderInfoArray填充内容
     3.reload tv
     */
    //NSLog(@"ZCViewController_Search_barbutton_submit_Click");
    [self.text_dst resignFirstResponder];
    [self.text_source resignFirstResponder];
    /*
     //客户端查询
    if ([self.text_source.text isEqualToString:@""]&&
        [self.text_dst.text isEqualToString:@""]) {
        //text_source与text_dst都为空 : do nothing
        //NSLog(@"text_source与text_dst都为空");
        self.orderInfoArray = self.staticOrderInfoArray;
    } else if ([self.text_source.text isEqualToString:@""]&&
               ![self.text_dst.text isEqualToString:@""]){
        //仅text_source为空
        //NSLog(@"仅text_source为空");
        self.orderInfoArray = [self loadOrderInfoArraywithDst:self.text_dst.text];
    } else if (![self.text_source.text isEqualToString:@""]&&
               [self.text_dst.text isEqualToString:@""]){
        //仅text_dst为空
        //NSLog(@"仅text_dst为空");
        self.orderInfoArray = [self loadOrderInfoArraywithSourece:self.text_source.text];
    }else{
        //text_source与text_dst都不为空
        //NSLog(@"text_source与text_dst都不为空");
        self.orderInfoArray = [self loadOrderInfoArraywithSourece:self.text_source.text Dst:self.text_dst.text];
    }
     */
    //服务器查询
    //GET 身边订单
    NSData *resultData = nil;
    HttpController *httpController = [[HttpController alloc]init];
    
    NSString *type = @"GET";
    //NSString *url = @"http://115.28.107.151:8082/t/app/order/?longitude=125&latitude=45";
    
    
    
    NSString *url = [NSString stringWithFormat:@"app/order_search/?longitude=%f&latitude=%f&or_start=%@&or_end=%@",self.longitude,self.latitude,self.text_source.text,self.text_dst.text];
    
    NSString *info = @"nil";
    //因为GET URL包含中文 故需做如下处理
    const char *str = [url UTF8String];
    NSString *surl = [NSString stringWithUTF8String:str];
    surl = [surl stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    //Finish
    
    resultData = [httpController httpHandleWithType:type url:surl info:info];
    
    //NSString *responseString = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    //NSLog(@"ZCViewController_Search_responseString:%@",responseString);
    
    //NSLog(@"ZCViewController_Search_barbutton_submit_Click_sourece=%@_dst=%@",self.text_source.text,self.text_dst.text);
    //NSLog(@"ZCViewController_Search_barbutton_submit_Click_url_%@",url);
    
    self.orderInfoArray = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error:nil];
    
    
    [self.tv reloadData];
}

- (void)tableViewConfig {
    //[self.tv removeGestureRecognizer:self.tap_clear];
    UINib *nib = [UINib nibWithNibName:@"ZCTableViewCell_WDDD" bundle:nil];
    [self.tv registerNib:nib forCellReuseIdentifier:@"ZCTableViewCell_WDDD"];
    //self.tv.delegate = self;
    self.tv.delegate = self;
    self.tv.dataSource = self;
    
    //self.tv
}

- (IBAction)tap_clear_Click:(id)sender {
    [self.text_dst resignFirstResponder];
    [self.text_source resignFirstResponder];
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
    NSString *cid = [currentRowinfo objectForKey:@"or_id"];
    self.currentOrderID = cid;
    
    /*
    NSNumber *or_status = [currentRowinfo objectForKey:@"or_status"];//当前订单状态
    int orderStatus = or_status.intValue;
    NSString *imageName = nil;
    switch (orderStatus) {
        case 0:
            imageName = @"ybj.png";
            break;
        case 1:
            imageName = @"jxz.png";
            break;
        case 2:
            imageName = @"ywc.png";
            break;
        case 3:
            imageName = @"ygb.png";
            break;
        default:
            break;
    }
    cell.iv_zt.image = [UIImage imageNamed:imageName];
     */
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
    //vc.currentOrderID = self.currentOrderID;
    
    NSDictionary *currentRowinfo = self.orderInfoArray[indexPath.row];//存放当前row数据信息
    
    NSString *cid = [currentRowinfo objectForKey:@"or_id"];
    vc.currentOrderID = cid;
    //vc.currentOrderID = self.currentOrderID;
    vc.currentDevis3_5Inch = self.currentDevis3_5Inch;
    
    [self.navigationController pushViewController:vc animated:true];
}

- (NSMutableArray*)loadOrderInfoArraywithSourece:(NSString*)text_Source Dst:(NSString*)text_Dst{
    NSMutableArray *dataMutableArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < _staticOrderInfoArray.count; i++) {
        NSDictionary *dataDic = _staticOrderInfoArray[i];
        NSString *sourceString = text_Source;
        NSString *dstString = text_Dst;
        //NSLog(@"ZCViewController_WDDD_roadOrderInfoArraywithTag_or_status=%@\n",[dataDic objectForKey:@"or_status"]);
        //NSLog(@"ZCViewController_WDDD_roadOrderInfoArraywithTag_tagString=%@\n",tagString);
        NSString *orderStart = [dataDic objectForKey:@"or_start"];
        NSString *orderEnd = [dataDic objectForKey:@"or_end"];
        //int or_Status = orderStatus.intValue;
        
        if ([sourceString isEqualToString:orderStart]&&[dstString isEqualToString:orderEnd]) {
            //NSLog(@"ZCViewController_WDDD_roadOrderInfoArraywithTag_beforeAddobject");
            [dataMutableArray addObject:dataDic];
            //NSLog(@"ZCViewController_Search_loadOrderInfoArraywithSourece_if");
        }
        else{
            //NSLog(@"ZCViewController_Search_loadOrderInfoArraywithSourece_else");
            //NSLog(@"ZCViewController_Search_loadOrderInfoArraywithSourece_sourceString=%@\n",sourceString);
            //NSLog(@"ZCViewController_Search_loadOrderInfoArraywithSourece_orderStart=%@\n",orderStart);
            //NSLog(@"ZCViewController_Search_loadOrderInfoArraywithSourece_dstString=%@\n",dstString);
            //NSLog(@"ZCViewController_Search_loadOrderInfoArraywithSourece_orderEnd=%@\n",orderEnd);
            
        }
     
    }
    return dataMutableArray;
}

- (NSMutableArray*)loadOrderInfoArraywithSourece:(NSString*)text_Source{
    NSMutableArray *dataMutableArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < _staticOrderInfoArray.count; i++) {
        NSDictionary *dataDic = _staticOrderInfoArray[i];
        NSString *sourceString = text_Source;
        //NSString *dstString = text_Dst;
        //NSLog(@"ZCViewController_WDDD_roadOrderInfoArraywithTag_or_status=%@\n",[dataDic objectForKey:@"or_status"]);
        //NSLog(@"ZCViewController_WDDD_roadOrderInfoArraywithTag_tagString=%@\n",tagString);
        NSString *orderStart = [dataDic objectForKey:@"or_start"];
        //NSString *orderEnd = [dataDic objectForKey:@"or_end"];
        //int or_Status = orderStatus.intValue;
        
        if ([sourceString isEqualToString:orderStart]) {
            //NSLog(@"ZCViewController_WDDD_roadOrderInfoArraywithTag_beforeAddobject");
            [dataMutableArray addObject:dataDic];
            //NSLog(@"ZCViewController_Search_loadOrderInfoArraywithSourece_if");
        }
        else{
            //NSLog(@"ZCViewController_Search_loadOrderInfoArraywithSourece_else");
            //NSLog(@"ZCViewController_Search_loadOrderInfoArraywithSourece_sourceString=%@\n",sourceString);
            //NSLog(@"ZCViewController_Search_loadOrderInfoArraywithSourece_orderStart=%@\n",orderStart);
            
            
        }
        
    }
    return dataMutableArray;
}

- (NSMutableArray*)loadOrderInfoArraywithDst:(NSString*)text_Dst{
    NSMutableArray *dataMutableArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < _staticOrderInfoArray.count; i++) {
        NSDictionary *dataDic = _staticOrderInfoArray[i];
        //NSString *sourceString = text_Source;
        NSString *dstString = text_Dst;
        //NSLog(@"ZCViewController_WDDD_roadOrderInfoArraywithTag_or_status=%@\n",[dataDic objectForKey:@"or_status"]);
        //NSLog(@"ZCViewController_WDDD_roadOrderInfoArraywithTag_tagString=%@\n",tagString);
        //NSString *orderStart = [dataDic objectForKey:@"or_start"];
        NSString *orderEnd = [dataDic objectForKey:@"or_end"];
        //int or_Status = orderStatus.intValue;
        
        if ([dstString isEqualToString:orderEnd]) {
            //NSLog(@"ZCViewController_WDDD_roadOrderInfoArraywithTag_beforeAddobject");
            [dataMutableArray addObject:dataDic];
            //NSLog(@"ZCViewController_Search_loadOrderInfoArraywithDst_if");
        }
        else{
            //NSLog(@"ZCViewController_Search_loadOrderInfoArraywithDst_else");
            //NSLog(@"ZCViewController_Search_loadOrderInfoArraywithDst_dstString=%@\n",dstString);
            //NSLog(@"ZCViewController_Search_loadOrderInfoArraywithDst_orderEnd=%@\n",orderEnd);
            
        }
        
    }
    return dataMutableArray;
}
@end

//
//  ZCViewController_DDXQ.m
//  ZCXD
//
//  Created by JackWee on 14-8-9.
//  Copyright (c) 2014年 JackWee. All rights reserved.
//

#import "ZCViewController_DDXQ.h"

@interface ZCViewController_DDXQ ()

@end

@implementation ZCViewController_DDXQ

- (void)viewDidLoad {
    
    [self getData];
    [super viewDidLoad];
    [self scrollConfig];
    // Do any additional setup after loading the view.
    [self.view addGestureRecognizer:self.tap_clear];
    [self titleViewConfig];
    [self textInfoConfig];
    [self textIntroduceConfig];
    
    [self textZCDDConfig];
    [self textXCDDConfig];
    [self textDHSJConfig];
    [self textDDSJConfig];
    [self textHPMCConfig];
    [self textHBConfig];
    [self textSLConfig];
    [self textZZLConfig];
    [self textBJConfig];
    [self submitConfig];
     
    NSLog(@"ZCViewController_DDXQ_cid=%@\ntel=%@\nla=%f\nlo=%f\n",self.currentOrderID,self.dr_tel,self.latitude,self.longitude);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)button_xd_Click:(id)sender {
    //先判断是已报价还是进行中 然后分别处理
    NSNumber *st = [self.infoDic objectForKey:@"or_status"];
    int status = st.intValue;
    
    NSData *resultData = nil;
    HttpController *httpController = [[HttpController alloc]init];
    
    NSString *type = @"POST";
    NSString *url = nil;
    NSString *info = nil;
    ZCViewController_PJ *vc = [[ZCViewController_PJ alloc]initWithNibName:@"ZCViewController_PJ" bundle:nil];
    switch (status) {
        case 0://已报价
            url = @"app/offer/";
            info = [NSString stringWithFormat:@"dr_tel=%@&or_id=%@&or_price=%@&longitude=%f&latitude=%f",self.dr_tel,self.currentOrderID,self.text_bj.text,self.longitude,self.latitude];
            break;
        case 1://进行中
            url = @"app/order_finish/";
            info = [NSString stringWithFormat:@"or_id=%@",self.currentOrderID];
            break;
        case 2:
            
            [self.navigationController pushViewController:vc animated:false];
            return;
            break;
        default:
            break;
    }
    
    /*
    NSData *resultData = nil;
    HttpController *httpController = [[HttpController alloc]init];
    
    NSString *type = @"POST";
    NSString *url = @"http://115.28.107.151:8082/t/app/offer/";
    NSString *info = [NSString stringWithFormat:@"dr_tel=%@&or_id=%d&or_price=%@&longitude=%f&latitude=%f",self.dr_tel,self.currentOrderID,self.text_bj.text,self.longitude,self.latitude];
     */
    //NSLog(@"cid=%d\ntel=%@\nla=%f\nlo=%f\n",self.currentOrderID,self.dr_tel,self.latitude,self.longitude);
    
    
    resultData = [httpController httpHandleWithType:type url:url info:info];
    
    NSString *responseString = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",responseString);
    
    NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error:nil];
    id result_status = [resultDic objectForKey:@"status"];
    //NSDictionary *infoDic = [resultDic objectForKey:@"data"];
    //NSLog(@"ZCViewController_DDXQ_status=%@",status);
    
    if (([result_status isEqualToString:@"1"])||
    ([result_status isEqualToString:@"2"])){
        //NSLog(@"333");
        ZCViewController_Root *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ZCViewController_Root"];
        //vc.infoDic = infoDic;
        //[self.navigationController pushViewController:vc animated:true];
        //[self.navigationController popToViewController:vc animated:true];
        //[self dismissViewControllerAnimated:true completion:nil];
        [self.navigationController popViewControllerAnimated:true];
        //[self.navigationController popToRootViewControllerAnimated:true];
    }
}

- (void)titleViewConfig{
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"订单详情"];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = customLab;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]init];
    backButton.title = @"返回";
    self.navigationItem.backBarButtonItem = backButton;
}

- (void)textInfoConfig{
    //self.label_info.font = [UIFont systemFontOfSize:14];
    self.label_info.text = [_infoDic objectForKey:@"or_title"];
    //CGSize size = CGSizeMake(320, 40);
    //self.scrollView.contentSize = size;
    //NSLog(@"ZCViewController_DDXQ_textInfoConfig_or_title%@",[_infoDic objectForKey:@"or_title"]);
}

- (void)textIntroduceConfig{
    self.text_introduce.font = [UIFont systemFontOfSize:14];
    //self.text_introduce.enabled = NO;
    self.text_introduce.text = [_infoDic objectForKey:@"or_request"];
}

- (void)textZCDDConfig{
    self.text_zcdd.enabled = NO;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
    label.font = [UIFont systemFontOfSize:13];
    label.text = [_infoDic objectForKey:@"or_start"];
    label.textAlignment = NSTextAlignmentLeft;
    self.text_zcdd.rightView = label;
    self.text_zcdd.rightViewMode = UITextFieldViewModeAlways;
    //NSLog(@"1");
}

- (void)textXCDDConfig{
    self.text_xcdd.enabled = NO;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
    label.font = [UIFont systemFontOfSize:13];
    label.text = [_infoDic objectForKey:@"or_end"];
    label.textAlignment = NSTextAlignmentLeft;
    self.text_xcdd.rightView = label;
    self.text_xcdd.rightViewMode = UITextFieldViewModeAlways;
}

- (void)textDHSJConfig{
    self.text_dhsj.enabled = NO;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
    label.font = [UIFont systemFontOfSize:13];
    label.text = [_infoDic objectForKey:@"or_startTime"];
    label.textAlignment = NSTextAlignmentLeft;
    self.text_dhsj.rightView = label;
    self.text_dhsj.rightViewMode = UITextFieldViewModeAlways;
}

- (void)textDDSJConfig{
    self.text_ddsj.enabled = NO;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
    label.font = [UIFont systemFontOfSize:13];
    label.text = [_infoDic objectForKey:@"or_endTime"];
    label.textAlignment = NSTextAlignmentLeft;
    self.text_ddsj.rightView = label;
    self.text_ddsj.rightViewMode = UITextFieldViewModeAlways;
}

- (void)textHPMCConfig{
    self.text_hpmc.enabled = NO;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
    label.font = [UIFont systemFontOfSize:13];
    label.text = [_infoDic objectForKey:@"or_name"];
    label.textAlignment = NSTextAlignmentLeft;
    self.text_hpmc.rightView = label;
    self.text_hpmc.rightViewMode = UITextFieldViewModeAlways;
}

- (void)textHBConfig{
    self.text_hb.enabled = NO;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
    label.font = [UIFont systemFontOfSize:13];
    //label.text = [_infoDic objectForKey:@"or_board"];
    NSNumber *num = [_infoDic objectForKey:@"or_board"];
    label.text = num.stringValue;
    label.textAlignment = NSTextAlignmentLeft;
    self.text_hb.rightView = label;
    self.text_hb.rightViewMode = UITextFieldViewModeAlways;
}

- (void)textSLConfig{
    self.text_sl.enabled = NO;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
    label.font = [UIFont systemFontOfSize:13];
    //label.text = [_infoDic objectForKey:@"or_number"];
    NSNumber *num = [_infoDic objectForKey:@"or_number"];
    label.text = num.stringValue;
    label.textAlignment = NSTextAlignmentLeft;
    self.text_sl.rightView = label;
    self.text_sl.rightViewMode = UITextFieldViewModeAlways;
}

- (void)textZZLConfig{
    self.text_zzl.enabled = NO;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
    label.font = [UIFont systemFontOfSize:13];
    label.text = [_infoDic objectForKey:@"or_weight"];
    label.textAlignment = NSTextAlignmentLeft;
    self.text_zzl.rightView = label;
    self.text_zzl.rightViewMode = UITextFieldViewModeAlways;
}

- (void)textBJConfig{
    //self.text_zcdd.enabled = NO;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"元  ";
    label.textAlignment = NSTextAlignmentRight;
    self.text_bj.rightView = label;
    self.text_bj.rightViewMode = UITextFieldViewModeAlways;
}

- (void)getData{
    NSData *resultData = nil;
    HttpController *httpController = [[HttpController alloc]init];
    
    NSString *type = @"GET";
    //NSString *url = @"http://115.28.107.151:8082/t/app/order/?longitude=125&latitude=45";
    NSString *url = [NSString stringWithFormat:@"app/detail/?or_id=%@",self.currentOrderID];
    
    NSString *info = @"nil";
    
    resultData = [httpController httpHandleWithType:type url:url info:info];
    
    NSString *resultString = [[NSString alloc]initWithData:resultData encoding:NSUTF8StringEncoding];
    NSLog(@"ZCViewController_DDXQ_getData%@",resultString);
    _infoDic  = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error:nil];
}

- (IBAction)tap_clear_Click:(id)sender {
    [self.text_bj resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"ZCViewController_DDXQ_textFieldDidBeginEditing");
}

- (void)scrollConfig{
    self.scrollView.bounces = NO;
    if (self.currentDevis3_5Inch == 1) {
        //self.toolbar.bounds = CGRectMake(0, 200, 320, 44);
        //self.scrollView.frame = CGRectMake(16, 114, 288, 400);
    } else {
        self.scrollView.frame = CGRectMake(16, 68, 297, 568);
    }
    //self.scrollView.frame = CGRectMake(16, 114, 288, 400);
    CGSize size = CGSizeMake(297, 700);
    self.scrollView.contentSize = size;
}

- (void)submitConfig{
    NSNumber *st = [self.infoDic objectForKey:@"or_status"];
    int status = st.intValue;
    CGSize size;
    switch (status) {
        case 0://已报价
            
            break;
        case 1://进行中
            //self.button_xd.frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
            self.button_xd.titleLabel.text = @"订单完成";
            self.text_bj.hidden = YES;
            size = CGSizeMake(297, 450);
            self.scrollView.contentSize = size;
            break;
        case 2://已完成 －> 评价
            //self.button_xd.hidden = YES;
            [self.button_xd setTitle:@"评价" forState:UIControlStateNormal];
            
            self.text_bj.hidden = YES;
            size = CGSizeMake(297, 450);
            self.scrollView.contentSize = size;
            break;
        case 3://已关闭
            self.button_xd.hidden = YES;
            self.text_bj.hidden = YES;
            size = CGSizeMake(297, 450);
            self.scrollView.contentSize = size;
            break;
        default:
            break;
    }
}

@end

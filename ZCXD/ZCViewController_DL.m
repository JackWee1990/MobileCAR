//
//  ZCViewController_DL.m
//  ZCXD
//
//  Created by JackWee on 14-8-8.
//  Copyright (c) 2014年 JackWee. All rights reserved.
//

#import "ZCViewController_DL.h"

@interface ZCViewController_DL ()

@end

@implementation ZCViewController_DL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.navigationController.title = @"登录";
    //self.navigationItem.title = @"haha";
    //改变title颜色
    [self titleConfig];
    [self textFieldConfig];
    [self buttonConfig];
    [self labelAttentionConfig];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.label_attention.hidden = YES;
    if (self.currentDevis3_5Inch == 1) {
        self.label_attention.center = CGPointMake(160, 420);
        
    } else {
        
    }
}

- (void)titleConfig{
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"登录"];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = customLab;
}

- (void)labelAttentionConfig{
    self.label_attention.backgroundColor = [UIColor clearColor];
    self.label_attention.layer.backgroundColor =[UIColor grayColor].CGColor;
    self.label_attention.layer.cornerRadius = 5;
}

- (void)textFieldConfig{
    [self textFieldZHConfig];
    [self textFieldMMConfig];
}

- (void)buttonConfig{
    
}

- (void)textFieldZHConfig{
    //self.text_zh.frame = CGRectMake(100, 100, 400, 50);
    /*
     //自定义leftview
    UIImageView *imageView_ZH = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    UIImage *image_ZH = [UIImage imageNamed:@"dl_zh.png"];
    [imageView_ZH setImage:image_ZH];
    self.text_zh.leftView = imageView_ZH;
    self.text_zh.leftViewMode = UITextFieldViewModeAlways;
     */
    /*
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    label.text = @"123";
    self.text_zh.leftView = label;
    self.text_zh.leftViewMode = UITextFieldViewModeAlways;
     */
    //NSLog(@"1");
}

- (void)textFieldMMConfig{
    //UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    //[button setTitle:@"123" forState:UIControlStateNormal];
    //self.text_mm.rightView = button;
    //UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    //label.text = @"123";
    //self.text_mm.rightView = button;
    //self.text_mm.rightViewMode = UITextFieldViewModeAlways;
    //self.text_mm.leftViewMode = UITextFieldViewModeAlways;
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

- (IBAction)button_zx_Click:(id)sender {
}

- (IBAction)button_dl_Click:(id)sender {
    
    NSData *resultData = nil;
    HttpController *httpController = [[HttpController alloc]init];
    
    NSString *type = @"POST";
    NSString *url = @"app/login/";
    NSString *info = [NSString stringWithFormat:@"dr_tel=%@&dr_pwd=%@",self.text_zh.text,self.text_mm.text];
    
    
    
    resultData = [httpController httpHandleWithType:type url:url info:info];
    
    NSString *responseString = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    NSLog(@"ZCViewController_DL_responseString:%@",responseString);
    
    NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error:nil];
    id status = [resultDic objectForKey:@"status"];
    self.infoDic = [resultDic objectForKey:@"data"];
    //NSLog(@"%@",status);
    
    if ([status isEqualToString:@"1"]) {
        //数据存放
        [self userDefaultConfig];
        
        
        //跳转
        ZCViewController_Root *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ZCViewController_Root"];
        vc.infoDic = self.infoDic;
        vc.isLogin = YES;
        [self.navigationController pushViewController:vc animated:true];
         
    } else {
        self.label_attention.hidden = NO;
    }
    
    
    
}

- (void)fillBasicInfoWithDic:(NSDictionary*)dataDic{
    
    
}

- (IBAction)tap_space_Click:(id)sender {
    [self.text_zh resignFirstResponder];
    [self.text_mm resignFirstResponder];
}

- (IBAction)backgroundTap:(id)sender{
    [self.text_zh resignFirstResponder];
    [self.text_mm resignFirstResponder];
}

- (void)userDefaultConfig{//登录后配置NSUserDefaults
    NSUserDefaults *userDefaults = [[NSUserDefaults standardUserDefaults]init];
    NSString *status_login = @"YES";
    NSString *dr_name = [self.infoDic valueForKey:@"dr_name"];
    NSString *dr_weight = [self.infoDic valueForKey:@"dr_weight"];
    NSString *dr_number = [self.infoDic valueForKey:@"dr_number"];
    NSString *dr_hand = [self.infoDic valueForKey:@"dr_hand"];
    NSString *dr_tel = [self.infoDic valueForKey:@"dr_tel"];
    NSString *dr_type = [self.infoDic valueForKey:@"dr_type"];
    NSString *dr_length = [self.infoDic valueForKey:@"dr_length"];
    //将登录状态 账号 姓名 作为全局变量
    [userDefaults setObject:status_login forKey:@"isLogin"];
    [userDefaults setObject:self.text_zh.text forKey:@"dr_tel"];//账号
    [userDefaults setObject:dr_name forKey:@"dr_name"];//姓名
    [userDefaults setObject:self.text_mm.text forKey:@"dr_pwd"];
    [userDefaults synchronize];
    //[userDefaults setObject:self.infoDic  forKey:@"infoDic"];
    /*
    [userDefaults setObject:dr_name forKey:@"dr_name"];
    [userDefaults setObject:dr_weight forKey:@"dr_weight"];
    [userDefaults setObject:dr_number forKey:@"dr_number"];
    [userDefaults setObject:dr_hand forKey:@"dr_hand"];
    [userDefaults setObject:dr_tel forKey:@"dr_tel"];
    [userDefaults setObject:dr_type forKey:@"dr_type"];
    [userDefaults setObject:dr_length forKey:@"dr_length"];
    */
}
@end

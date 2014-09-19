//
//  ZCViewController_SZ.m
//  ZCXD
//
//  Created by JackWee on 14-8-9.
//  Copyright (c) 2014年 JackWee. All rights reserved.
//

#import "ZCViewController_SZ.h"

@interface ZCViewController_SZ ()

@end

@implementation ZCViewController_SZ

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _arr = [NSArray arrayWithObjects:@"注销", @"接收推送", @"意见反馈", @"检查更新", @"关于",nil];
    self.tv.delegate = self;
    self.tv.dataSource = self;
    [self titleViewConfig];
    self.automaticallyAdjustsScrollViewInsets = NO;
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_cfg"];
    //[cell setFrame:CGRectMake(0, 0, 280, 44)];
    //cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = _arr[indexPath.row];
    if (indexPath.row == 1) {//接收推送列 右侧添加Switch
        self.switchView = [[UISwitch alloc] initWithFrame:CGRectMake(220, 5, 51, 31)];
        [cell.contentView addSubview:self.switchView];
        [self.switchView addTarget:self action:@selector(switchAction) forControlEvents:UIControlEventValueChanged];
    } else {
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (void)titleViewConfig{
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"设置"];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = customLab;
    //设置pushView的返回按钮
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]init];
    
    backButton.title = @"返回";
    //backButton.tintColor = [UIColor whiteColor];
    
    self.navigationItem.backBarButtonItem = backButton;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //NSLog(@"ZCViewController_SZ_didSelectRowAtIndexPath_indexPath=%ld",(long)indexPath.row);
    int currentRow = indexPath.row;
    if (currentRow == 0) {//注销
        self.alertView = [[UIAlertView alloc]initWithTitle:@"注意" message:@"确定要注销吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"注销", nil];
        self.alertView.center = CGPointMake(160, 200);
        [self.alertView show];
        //[self.view addSubview:self.alertView];
        /*
        ZCViewController_Root *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ZCViewController_Root"];
        vc.isLogin = NO;
        [self.navigationController popToRootViewControllerAnimated:true];
         */
    } else if (currentRow == 1){//接收推送
        
    }else if (currentRow == 2){//意见反馈
        ZCUIViewController_SZ_YJFK *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ZCUIViewController_SZ_YJFK"];
        [self.navigationController pushViewController:vc animated:true];
    }else if (currentRow == 3){//检查更新
        
    }else if (currentRow == 4){//关于
        ZCUIViewController_SZ_GY *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ZCUIViewController_SZ_GY"];
        [self.navigationController pushViewController:vc animated:true];
    }
}
- (void)switchAction{
    //NSLog(@"ZCViewController_SZ_switchAction_on:%hhd",self.switchView.on);
    BOOL switchStatus = self.switchView.on;
    if (switchStatus) {//接收推送
        //NSLog(@"ZCViewController_SZ_switchAction_switchStatus=YES");
    } else {//拒绝推送
        //NSLog(@"ZCViewController_SZ_switchAction_switchStatus=NO");
    }
}

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //NSLog(@"ZCViewController_SZ_buttonIndex=%ld\n",(long)buttonIndex);
    if (buttonIndex == 1) {
        ZCViewController_Root *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ZCViewController_Root"];
        vc.isLogin = NO;
        NSUserDefaults *userDefault = [[NSUserDefaults standardUserDefaults]init];
        [userDefault setObject:nil forKey:@"isLogin"];
        //[userDefault setObject:nil forKey:@"infoDic"];
        [userDefault setObject:nil forKey:@"dr_tel"];
        [userDefault setObject:nil forKey:@"dr_name"];
        [userDefault synchronize];
        //[self.navigationController popToRootViewControllerAnimated:true];
        [self.navigationController pushViewController:vc animated:true];
    }
}
@end

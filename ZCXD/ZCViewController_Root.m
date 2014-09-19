//
//  ZCViewController_Root.m
//  ZCXD
//
//  Created by JackWee on 14-8-8.
//  Copyright (c) 2014年 JackWee. All rights reserved.
//

#import "ZCViewController_Root.h"

@interface ZCViewController_Root ()

@end

@implementation ZCViewController_Root
@synthesize annotations = _annotations;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentDevis3_5Inch = [self is3_5Inch];
    
    
    [self getDataFromUserDefault];
    // Do any additional setup after loading the view.
    //[self aMapSearchConfig];
    //NSLog(@"ZCViewController_Root_viewDidLoad_currentDevis3_5Inch=%hhd",self.currentDevis3_5Inch);
    _arr = [NSArray arrayWithObjects:@"个人信息",@"车辆信息",@" 我的订单",@"设置", nil];
    _arr_logo = [NSArray arrayWithObjects:@"sz_wdxx.png",@"sz_clxx.png",@"sz_wddd.png",@"sz_sz.png", nil];
    [self mapSearchConfig];
    
    
    [self tapConfig];
    [self navigationBarConfig];
    [self locationMangerConfig];
    //[self tapConfig];
    [self maMapConfig];
    
    //[self annotationConfig];
    //[self.mapView addAnnotations:self.annotations];
    //[self label_messageConfig];
    //将navigationBar的Item BG设为白色
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    //[self test];
    //NSString *maxweight = [_infoDic valueForKey:@"dr_weight"];
    //NSLog(@"VCController_mw=%@",maxweight);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)navigationBarConfig{
    //self.navigationItem.titleView.backgroundColor = [UIColor orangeColor];
    UIImage *titlelogo = [UIImage imageNamed:@"image_root_logo.png"];
    //CGFloat height = titlelogo.size.height;
    //CGFloat width = titlelogo.size.width;
    //NSLog(@"height = %f\nwidth = %f\n",height,width);
    //[titlelogo drawInRect:CGRectMake(0, 0, width*3/5, height*3/5)];
    //[titlelogo scaleToSize:]
    //CGSize reSize = CGSizeMake(width*3/5, height*3/5);
    //UIImage *newlogo = [[UIImage alloc]init];
    //newlogo = [self scaleImage:titlelogo to
    UIImageView *tView = [[UIImageView alloc]initWithImage:titlelogo];
    [tView setFrame:CGRectMake(0, 0, 168, 42)];
    self.navigationItem.titleView = tView;
  
    //设置leftBarButtonItem
    UIImage *leftImage = [UIImage imageNamed:@"image_root_cfg"];
    UIImageView *leftView = [[UIImageView alloc]initWithImage:leftImage];
    [leftView setFrame:CGRectMake(0, 0, 20, 15)];
    [leftView addGestureRecognizer:_tap_menu];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftView];
    
    
    //设置pushView的返回按钮
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]init];

    backButton.title = @"返回";
    //backButton.tintColor = [UIColor whiteColor];
    
    self.navigationItem.backBarButtonItem = backButton;
    //self.navigationController.navigationItem.backBarButtonItem.tintColor = [UIColor whiteColor];
}
- (void)locationMangerConfig {
    self.locationManger = [[CLLocationManager alloc]init];
    self.locationManger.delegate = self;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        [self.locationManger requestAlwaysAuthorization];//ios8
    }
    //[self.locationManger requestAlwaysAuthorization];//ios8
    self.locationManger.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManger.distanceFilter = kCLDistanceFilterNone;
    [self locUpdate];
    [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(locUpdate) userInfo:nil repeats:true];
    
    
}
- (void)maMapConfig {
    self.mapView=[[MAMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    self.mapView.delegate = self;

    [self.view addSubview:self.mapView];
    [self.mapView addGestureRecognizer:_tap_map];


    _mapView.showsUserLocation =YES; //设置为可以显示用户位置
    //_mapView.compassOrigin = CGPointMake(10, 440);
    _mapView.showsCompass = YES;//显示罗盘
    if (self.currentDevis3_5Inch == 1) {
        _mapView.compassOrigin = CGPointMake(10, 430);
        _mapView.scaleOrigin = CGPointMake(180, 430);
    } else {
        _mapView.compassOrigin = CGPointMake(10, 515);
        _mapView.scaleOrigin = CGPointMake(180, 515);
    }
    
    //_mapView.compassOrigin = CGPointMake(10, 515);
    
    
   // _mapView.scaleOrigin = CGPointMake(200, 440);//比例尺
    //_mapView.scaleOrigin = CGPointMake(200, 515);
    _mapView.showsScale = YES;
    /*
    CLLocationCoordinate2D coordinate; //设定经纬度
    coordinate.latitude =45.75000; //纬度
    coordinate.longitude =126.63333; //经度
    MACoordinateRegion viewRegion =MACoordinateRegionMake(coordinate, MACoordinateSpanMake(0.2,0.2));
    [_mapView setRegion:viewRegion];*/

}
- (void)tapConfig {
    _tap_map = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_On_map:)];
    //_tap_map = [[UITapGestureRecognizer alloc]init];
    //[self.mapView addGestureRecognizer:_tap_map];
    
    _tap_menu_left = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(tap_On_menu_left:)];
    _tap_menu_left.direction = UISwipeGestureRecognizerDirectionLeft;
    
    _tap_menu = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(barbutton_menu_Click:)];
    _tap_On_imagelogo_and_labelName = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_On_imagelogo_and_labelName_Click:)];
    //_tap_lableMessage = [[UITapGestureRecognizer alloc]initWithTarget:self.label_message action:@selector(barbutton_search_Click:)];

}
- (void)annotationConfig {
    self.annotations = [NSMutableArray array];
    /*
    CLLocationCoordinate2D c1 = CLLocationCoordinate2DMake(45.760000, 126.630005);
    //这块需要创建个NSMutableArray来存储CLLocationCoordinate2D
    ZCAnnotationMake *am1 = [[ZCAnnotationMake alloc]initWithCoordinate:c1];
    //MAAnnotationView *mav1 = [[MAAnnotationView alloc]initWithAnnotation:am1 reuseIdentifier:@"1"];
    //MAAnnotationView *mav1 = [_mapView viewForAnnotation:am1];
    //mav1.image = [UIImage imageNamed:@"image_root_xiaoche_red.png"];
    [self.annotations insertObject:am1 atIndex:0];
    //NSLog(@"!!!!!!!!!!!!!!!!!!!!!!!!!!!!%lu",(unsigned long)self.annotations.count);
    //[self.mapView addAnnotations:self.annotations];
    //MAAnnotationView *mav = [[MAAnnotationView alloc]initWithAnnotation:am1 reuseIdentifier:@"1"];
    //[self.mapView addAnnotation:am1];
    //MAAnnotationView *mav1 = [[MAAnnotationView alloc]initWithAnnotation:am1 reuseIdentifier:@"0"];
    CLLocationCoordinate2D c2 = CLLocationCoordinate2DMake(45.761110, 126.620035);
    ZCAnnotationMake *am2 = [[ZCAnnotationMake alloc]initWithCoordinate:c2];
    [self.annotations insertObject:am2 atIndex:1];
    //[self.mapView addAnnotation:am2];
    //MAAnnotationView *mav2 = [[MAAnnotationView alloc]initWithAnnotation:am2 reuseIdentifier:@"1"];
    [self.mapView addAnnotations:self.annotations];
    */
    //1.取坐标 2.创建ZCAnnotationMake 3.放入annotations中 4.addAnnotations

    for (int i=0; i < _aroundOrderInfo.count; i++) {
        NSDictionary *aroundOrderRowInfo = _aroundOrderInfo[i];
        id _latitude = [aroundOrderRowInfo objectForKey:@"or_latitude"];
        NSNumber *la = _latitude;
        //latitude = la in
        id _longitude = [aroundOrderRowInfo objectForKey:@"or_longitude"];
        NSNumber *lo = _longitude;
        CLLocationCoordinate2D cc2d = CLLocationCoordinate2DMake(la.doubleValue,lo.doubleValue);
        ZCAnnotationMake *am = [[ZCAnnotationMake alloc]initWithCoordinate:cc2d];
        NSString *id = [aroundOrderRowInfo objectForKey:@"or_id"];
        am.or_id = id;
        am.or_title = [aroundOrderRowInfo objectForKey:@"or_title"];
        am.or_start = [aroundOrderRowInfo objectForKey:@"or_start"];
        am.or_end = [aroundOrderRowInfo objectForKey:@"or_end"];
        [self.annotations insertObject:am atIndex:i];
        //NSLog(@"or_id=%d\nor_title=%@\nor_start=%@\nor_end=%@\n",am.or_id,am.or_title,am.or_start,am.or_end);
        MAAnnotationView *mv = [[MAAnnotationView alloc]initWithAnnotation:am reuseIdentifier:id];
        /*
        if (mv.selected == YES) {
            _info.label_cpy.text = am.or_title;
            _info.label_source.text = am.or_start;
            _info.label_cpy.text = am.or_end;
        }*/
    }
    [self.mapView addAnnotations:self.annotations];
    
}
- (void)label_messageConfig{
    _label_message = [[UILabel alloc]initWithFrame:CGRectMake(10, 90, 300, 35)];

    _label_message.text = [NSString stringWithFormat:@"附近有%lu个用车需求",(unsigned long)_aroundOrderInfo.count];
    _label_message.backgroundColor = [UIColor clearColor];
    _label_message.textColor = [UIColor whiteColor];
    _label_message.textAlignment = NSTextAlignmentCenter;
    //NSLog(@"qqqqqq%f",_label_message.layer.bounds.size.height);
    _label_message.layer.backgroundColor =[UIColor orangeColor].CGColor;
    _label_message.layer.cornerRadius = 10;
    
    if (_aroundOrderInfo.count == 0) {
        
    } else {
        [_label_message addGestureRecognizer:_tap_lableMessage];
        _label_message.userInteractionEnabled = YES;
        [self.mapView addSubview:_label_message];
    }
    

}
 

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)barbutton_menu_Click:(id)sender {
    
    if (!self.menu) {
        [self addZCUIView_Menu];
        self.menu.frame = self.menu.frame = CGRectMake(-200, 0, 200, 568);
        [UIView animateWithDuration:0.3 animations:^{
            self.menu.frame = self.menu.frame = CGRectMake(0, 0, 200, 568);
            self.mapView.alpha = 0.5;
        }];
         /*
        [UIView animateWithDuration:10 animations:^{
            [self addZCUIView_Menu];
        } completion:^(BOOL finished) {
            self.menu.frame = CGRectMake(0, 0, 200, 568);
        }];*/
        //[self addZCUIView_Menu];
    }
    else{
        [self menuClear];
    }
    
}

- (IBAction)barbutton_search_Click:(id)sender {
    
    if (self.isLogin == YES) {
        ZCViewController_Search *searchView = [self.storyboard instantiateViewControllerWithIdentifier:@"ZCViewController_Search"];
        //[self.navigationController popToViewController:searchView animated:true];
        searchView.currentOrderID = self.currentOrderID;
        searchView.dr_tel = [[NSUserDefaults standardUserDefaults]objectForKey:@"dr_tel"];//[self.infoDic valueForKey:@"dr_tel"];
        //[[NSUserDefaults standardUserDefaults]objectForKey:@"dr_tel"];
        searchView.latitude = self._latitude_;
        searchView.longitude = self._longitude_;
        searchView.orderInfoArray = self.aroundOrderInfo;
        searchView.staticOrderInfoArray = self.aroundOrderInfo;
        searchView.currentDevis3_5Inch = self.currentDevis3_5Inch;
        [self.navigationController pushViewController:searchView animated:true];
    }
    else{
        [self pushViewControllerDL];
    }
    
    
}

- (IBAction)tap_On_imagelogo_and_labelName_Click:(id)sender {
    //NSLog(@"ZCViewController_Root_tap_On_imagelogo_and_labelName_Click");
    [self pushViewControllerDL];
    
}

- (IBAction)tap_lableMessage_Click:(id)sender {
    //NSLog(@"ZCViewController_Root_tap_lableMessage_Click");
    if (self.isLogin == YES) {
        ZCViewController_Search *searchView = [self.storyboard instantiateViewControllerWithIdentifier:@"ZCViewController_Search"];
        //[self.navigationController popToViewController:searchView animated:true];
        searchView.currentOrderID = self.currentOrderID;
        searchView.dr_tel = [[NSUserDefaults standardUserDefaults]objectForKey:@"dr_tel"];//[self.infoDic valueForKey:@"dr_tel"];
        
        searchView.latitude = self._latitude_;
        searchView.longitude = self._longitude_;
        searchView.orderInfoArray = self.aroundOrderInfo;
        searchView.staticOrderInfoArray = self.aroundOrderInfo;
        searchView.currentDevis3_5Inch =self.currentDevis3_5Inch;
        [self.navigationController pushViewController:searchView animated:true];
    }
    else{
        [self pushViewControllerDL];
    }
}

- (void)addZCUIView_Menu {
    /*var xibview:NSArray = NSBundle.mainBundle().loadNibNamed("View", owner: self, options: nil) as NSArray
    view_cfg = xibview.lastObject as? CFGView
    //last.backgroundColor = UIColor.blueColor()
    view_cfg!.label_name.text = "123"
    view_cfg!.tableview.delegate = self
    view_cfg!.tableview.dataSource = self
    self.view.addSubview(view_cfg!)*/
    //NSLog(@"123");
    //关联UIView
    NSArray *xibview = [[NSBundle mainBundle] loadNibNamed:@"ZCUIView_Menu" owner:self options:nil];
    //NSLog(@"12345");
    _menu = xibview[0];
    //注册UITableViewCell
    /*
    UINib *nib = [UINib nibWithNibName:@"ZCMenuTableViewCell" bundle:nil];
    [_menu.tv registerNib:nib forCellReuseIdentifier:@"ZCMenuTableViewCell"];
    */
    
    //[_menu setBackgroundColor:[UIColor whiteColor]];
    _menu.tv.dataSource = self;
    _menu.tv.delegate = self;
    [_menu.tv setBackgroundColor:[UIColor clearColor]];
    
    //_menu.frame = CGRectMake(0, 20, <#CGFloat width#>, <#CGFloat height#>)
    //_menu.imageview_tx.image = [UIImage imageNamed:@"sz_touxiang.png"];
    //_menu.label_name.text = @"赵师傅";
    NSString *username = [[NSUserDefaults standardUserDefaults]objectForKey:@"dr_name"];//[_infoDic objectForKey:@"dr_name"];
    _menu.label_name.textColor = [UIColor whiteColor];
    if (self.isLogin == YES) {
        _menu.label_name.text = username;
    }else{
        _menu.label_name.text = @"请登录";
    }
    
    //_menu.label_name.text = username;
    _menu.label_name.textAlignment = NSTextAlignmentCenter;
    //[_menu sizeThatFits:CGSizeMake(200, 568)];
    //设置背景图片
    
    /*
    UIImage *bImage = [UIImage imageNamed:@"sz_background.png"];
    UIImageView *bImageView = [[UIImageView alloc]initWithImage:bImage];
    [_menu addSubview:bImageView];
    [_menu sendSubviewToBack:bImageView];
    */
    [_menu setBackgroundColor:[UIColor blackColor]];
    //self.mapView.alpha = 0.5;
    
    [self.view addSubview:_menu];
    //self.menu.frame = CGRectMake(0, 0, 200, 568);
    [_menu addGestureRecognizer:_tap_menu_left];
    if (self.isLogin == NO) {//若没登录 点击menu跳至登录页面
        [_menu addGestureRecognizer:_tap_On_imagelogo_and_labelName];
    }
    else{
        [_menu removeGestureRecognizer:_tap_On_imagelogo_and_labelName];
    }
    //[_menu.imageview_tx addGestureRecognizer:_tap_On_imagelogo_and_labelName];
    //[_menu.label_name addGestureRecognizer:_tap_On_imagelogo_and_labelName];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_arr count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPat {
    //NSLog(@"1");
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ZCMenuTableViewCell"];
    //与定制cell绑定
    //ZCMenuTableViewCell *cell = [_menu.tv dequeueReusableCellWithIdentifier:@"ZCMenuTableViewCell" ];
    //NSLog(@"12");
    //cell HostsLayoutEngine = YES;
    [cell setBackgroundColor:[UIColor clearColor]];
    //[cell.imageView sizeThatFits:CGSizeMake(25, 35)];
    //cell.imageView.image = [UIImage imageNamed:_arr_logo[indexPat.row]];
    //cell.imageView.frame = CGRectMake(0, 0, 100, 1);
    
    UIImage *image = [UIImage imageNamed:_arr_logo[indexPat.row]];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.frame = CGRectMake(10, 15, 25, 20);
    [cell.contentView addSubview:imageView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = _arr[indexPat.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    //cell.image_logo.image = [UIImage imageNamed:_arr_logo[indexPat.row]];
    /*
    switch (indexPat.row) {
        case 0:
            cell.image_logo.image = [UIImage imageNamed:@"sz_wdxx.png"];
            break;
        case 1:
            cell.image_logo.image = [UIImage imageNamed:@"sz_clxx.png"];
            break;
        case 2:
            cell.image_logo.image = [UIImage imageNamed:@"sz_wddd.png"];
            break;
        case 3:
            cell.image_logo.image = [UIImage imageNamed:@"sz_sz.png"];
            break;
        default:
            break;
    }
     */
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.isLogin == YES) {
        if (indexPath.row == 0) {
            ZCViewController_GRXX *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ZCViewController_GRXX"];
            vc.infoDic = self.infoDic;
            [self.navigationController pushViewController:vc animated:true];
            
        }else if( indexPath.row == 1){
            ZCViewController_CLXX *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ZCViewController_CLXX"];
            vc.infoDic = self.infoDic;
            [self.navigationController pushViewController:vc animated:true];
            
        }else if( indexPath.row == 2){
            
            ZCViewController_WDDD *vc = nil;
            
            if (self.currentDevis3_5Inch == 1) {
                vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ZCViewController_WDDD_3_5"];
            } else {
                vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ZCViewController_WDDD"];
            }
            //vc.infoDic = self.infoDic;
            vc.dr_tel = [[NSUserDefaults standardUserDefaults]objectForKey:@"dr_tel"];//[self.infoDic valueForKey:@"dr_tel"];
            
            vc.latitude = self._latitude_;
            vc.longitude = self._longitude_;
            vc.currentDevis3_5Inch = self.currentDevis3_5Inch;
            vc.address = self.address;
            [self.navigationController pushViewController:vc animated:true];
            
        }else if( indexPath.row == 3){
            ZCViewController_SZ *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ZCViewController_SZ"];
            //vc.infoDic = self.infoDic;
            [self.navigationController pushViewController:vc animated:true];
        }
    } else {
        [self pushViewControllerDL];
    }
    
    
    
    /*
    UIViewController *vc = [[UIViewController alloc] init];
    //NSLog(@"%ld",(long)indexPath.row);
    switch (indexPath.row) {
        case 0:
            //NSLog(@"000000000000");
            vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ZCViewController_GRXX"];
            break;
        case 1:
            //NSLog(@"1");
            vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ZCViewController_CLXX"];
            break;
        case 2:
            //NSLog(@"2");
            vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ZCViewController_WDDD"];
            break;
        case 3:
            //NSLog(@"3");
            vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ZCViewController_SZ"];
            break;
        default:
            NSLog(@"0");
            break;
    }
    [self.navigationController pushViewController:vc animated:true];
     */
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (IBAction)tap_On_map:(id)sender {
    //NSLog(@"tap_On_map");
    //NSLog(sender);
    //_mapView.compassOrigin = CGPointMake(10, 515);
    //_mapView.scaleOrigin = CGPointMake(200, 515);
    //_mapView.alpha = 1.0;
    //[self.menu removeFromSuperview];
    //[self.info removeFromSuperview];
    //self.menu = nil;
    [self menuClear];
    [self infoClear];
}

- (IBAction)tap_On_info:(id)sender {
    
    if (self.isLogin == YES) {
        ZCViewController_DDXQ *ddxq = [self.storyboard instantiateViewControllerWithIdentifier:@"ZCViewController_DDXQ"];
        ddxq.currentOrderID = self.currentOrderID;
        ddxq.dr_tel = [[NSUserDefaults standardUserDefaults]objectForKey:@"dr_tel"];//[self.infoDic valueForKey:@"dr_tel"];
        
        ddxq.latitude = self._latitude_;
        ddxq.longitude = self._longitude_;
        ddxq.currentDevis3_5Inch = self.currentDevis3_5Inch;
        [self.navigationController pushViewController:ddxq animated:true];
    } else {
        [self pushViewControllerDL];
    }
    
}

- (IBAction)tap_On_menu_left:(id)sender {
    //NSLog(@"tap_On_menu_left");
    
    [self menuClear];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    //NSLog(@"latitude:%f\n",newLocation.coordinate.latitude);
    //NSLog(@"longitude%f\n",newLocation.coordinate.longitude);
    //[self.locationManger stopUpdatingLocation];
    
    CLLocationCoordinate2D coordinate; //设定经纬度
    coordinate.latitude =newLocation.coordinate.latitude; //纬度
    coordinate.longitude =newLocation.coordinate.longitude; //经度
    MACoordinateRegion viewRegion =MACoordinateRegionMake(coordinate, MACoordinateSpanMake(0.1,0.1));
    [_mapView setRegion:viewRegion];
    
    [self.locationManger stopUpdatingLocation];
    
    //获取当前位置后，根据当前的经纬度GET周边订单信息
    [self getAroundOrderInfo:coordinate];
    self._latitude_ = coordinate.latitude;
    self._longitude_ = coordinate.longitude;
    
    //地址逆向解析
    [self searchReGeocode];
    
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"ZCViewController_Root_locationManager_error:\n%@",error);
    //[self.locationManger startUpdatingLocation];
    CLLocationCoordinate2D coordinate; //设定经纬度
    coordinate.latitude =45.75000; //纬度
    coordinate.longitude =126.63333; //经度
    MACoordinateRegion viewRegion =MACoordinateRegionMake(coordinate, MACoordinateSpanMake(0.1,0.1));
    [_mapView setRegion:viewRegion];
    
    //若地理位置更新失败，根据给定经纬度GET周边订单信息
    [self getAroundOrderInfo:coordinate];
    self._latitude_ = coordinate.latitude;
    self._longitude_ = coordinate.longitude;
    
    //地址逆向解析
    [self searchReGeocode];
}
/*
- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    NSLog(@"%lu",(unsigned long)self.annotations.count);
}
*/
/*!
 @brief 当选中一个annotation views时，调用此接口
 @param mapView 地图View
 @param views 选中的annotation views
 */
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{/*
    _mapView.compassOrigin = CGPointMake(10, 440);
    _mapView.scaleOrigin = CGPointMake(200, 440);
    if (self.info) {
        //NSLog(@"AH");
        [self.info removeFromSuperview];
    }
    //NSLog(@"%@",view.reuseIdentifier);
    NSArray *xibview = [[NSBundle mainBundle] loadNibNamed:@"ZCUIView_Info" owner:self options:nil];
    //NSLog(@"12345");
    _info = xibview[0];
    _info.center = CGPointMake(160, 524);
    _info.image_logo.image = [UIImage imageNamed:@"xiaoche.png"];
    //NSLog(@"%@\n",view.annotation.or_title);
    //_info.label_cpy.text = view.annotation.or_title;
    ZCAnnotationMake *zm = view.annotation;
    _info.label_cpy.text = zm.or_title;
    //_info.label_cpy.text = @"黑龙江私营工厂寻找货物物流合作";
    _info.label_cpy.textColor = [UIColor redColor];
    //_info.label_cpy.adjustsFontSizeToFitWidth = YES;
    _info.label_source.text = zm.or_start;
    //_info.label_source.adjustsFontSizeToFitWidth = YES;
    _info.label_dst.text = zm.or_end;
    //_info.label_dst.adjustsFontSizeToFitWidth = YES;
    _currentOrderID = zm.or_id;
    
    
    _info.label_cpy.font = [UIFont systemFontOfSize:15];
    _info.label_source.font = [UIFont systemFontOfSize:12];
    _info.label_dst.font = [UIFont systemFontOfSize:12];
    */
    //--------------------------------------
    //[self.view addSubview:_info];
    //[_info addGestureRecognizer:_tap_info];
    if ((view.annotation.coordinate.latitude == _mapView.userLocation.coordinate.latitude)&&
        (view.annotation.coordinate.longitude == _mapView.userLocation.coordinate.longitude)) {
        //通过该判断使当点击userLocation时view.image不改变 clear info
        if (self.info) {
            //NSLog(@"AH");
            [self infoClear];
        }
    } else {
        if (self.currentDevis3_5Inch == 1) {
            _mapView.compassOrigin = CGPointMake(10, 355);
            _mapView.scaleOrigin = CGPointMake(180, 355);
        } else {
            _mapView.compassOrigin = CGPointMake(10, 440);
            _mapView.scaleOrigin = CGPointMake(180, 440);
        }
        if (self.info) {
            //NSLog(@"AH");
            [self.info removeFromSuperview];
        }
        //NSLog(@"%@",view.reuseIdentifier);
        NSArray *xibview = [[NSBundle mainBundle] loadNibNamed:@"ZCUIView_Info" owner:self options:nil];
        //NSLog(@"12345");
        _info = xibview[0];
        
        if (self.currentDevis3_5Inch == 1) {
            _info.center = CGPointMake(160, 436);
        } else {
            _info.center = CGPointMake(160, 524);
        }

        _info.image_logo.image = [UIImage imageNamed:@"xiaoche.png"];
        //NSLog(@"%@\n",view.annotation.or_title);
        //_info.label_cpy.text = view.annotation.or_title;
        ZCAnnotationMake *zm = view.annotation;
        _info.label_cpy.text = zm.or_title;
        //_info.label_cpy.text = @"黑龙江私营工厂寻找货物物流合作";
        _info.label_cpy.textColor = [UIColor redColor];
        //_info.label_cpy.adjustsFontSizeToFitWidth = YES;
        _info.label_source.text = zm.or_start;
        //_info.label_source.adjustsFontSizeToFitWidth = YES;
        _info.label_dst.text = zm.or_end;
        //_info.label_dst.adjustsFontSizeToFitWidth = YES;
        _currentOrderID = zm.or_id;
        
        
        _info.label_cpy.font = [UIFont systemFontOfSize:15];
        _info.label_source.font = [UIFont systemFontOfSize:12];
        _info.label_dst.font = [UIFont systemFontOfSize:12];
        
        
        view.image = [UIImage imageNamed:@"image_root_xiaoche_blue.png"];
        
        [self.view addSubview:_info];
        [_info addGestureRecognizer:_tap_info];
    }
    
}

/*!
 @brief 根据anntation生成对应的View
 @param mapView 地图View
 @param annotation 指定的标注
 @return 生成的标注View
 */

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation{
    _maView = [[MAAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"1"];
    _maView.draggable = NO;
    //判断是否为UserLocation
    if ((annotation.coordinate.latitude == _mapView.userLocation.coordinate.latitude)&&
    (annotation.coordinate.longitude == _mapView.userLocation.coordinate.longitude))
    {
        //NSLog(@"USerLocation");
        //NSString *path = [[NSBundle mainBundle] pathForResource:@"userlocation" ofType:@"png"];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"userlocation" ofType:@"png" inDirectory:@"AMap.bundle/images/"];
    

        _maView.image = [UIImage imageWithContentsOfFile:path];
        
    }
    else{
        //_maView.image = [UIImage imageNamed:@"image_root_xiaoche_red.png"];

        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"image_root_xiaoche_red" ofType:@"png"];
        _maView.image = [UIImage imageWithContentsOfFile:path];
    }
    //NSLog(@"%@",annotation.coordinate);
    return _maView;
    
    
}

/*!
 @brief 当取消选中一个annotation views时，调用此接口
 @param mapView 地图View
 @param views 取消选中的annotation views
 */
- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view{
    //view.image = [UIImage imageNamed:@"image_root_xiaoche_red.png"];
    if ((view.annotation.coordinate.latitude == _mapView.userLocation.coordinate.latitude)&&
        (view.annotation.coordinate.longitude == _mapView.userLocation.coordinate.longitude)) {
        
    } else {
        view.image = [UIImage imageNamed:@"image_root_xiaoche_red.png"];
    }
}

- (void)getAroundOrderInfo:(CLLocationCoordinate2D)coordinate{
    
    
    CLLocationDegrees longitude = coordinate.longitude;
    CLLocationDegrees latitude = coordinate.latitude;
     //GET 身边订单
     NSData *resultData = nil;
     HttpController *httpController = [[HttpController alloc]init];
     
     NSString *type = @"GET";
     //NSString *url = @"http://115.28.107.151:8082/t/app/order/?longitude=125&latitude=45";
    
    NSString *url = [NSString stringWithFormat:@"app/order/?longitude=%f&latitude=%f",longitude,latitude];
    
     NSString *info = @"nil";
     
     resultData = [httpController httpHandleWithType:type url:url info:info];
    
    _aroundOrderInfo = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error:nil];
    //NSLog(@"%lu",(unsigned long)_aroundOrderInfo.count);
    //NSString *responseString = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    //NSLog(@"ZCViewController_Root_getAroundOrderInfo_responseString%@",responseString);
    //aroundOrderInfo取到内容后，将label_message及annotation相应显示出来
    [self label_messageConfig];
    [self annotationConfig];
    
}

- (void)menuClear{
    [UIView animateWithDuration:0.3 animations:^{
        self.menu.frame = CGRectMake(-200, 0, 200, 568);
        self.mapView.alpha = 1.0;
    } completion:^(BOOL finished) {
        [self.menu removeFromSuperview];
        self.menu = nil;
    }];
}

- (void)infoClear{
    [UIView animateWithDuration:0.3 animations:^{
        if (self.info) {
            
            if (self.currentDevis3_5Inch == 1) {
                self.info.center = CGPointMake(160, 515);
                _mapView.compassOrigin = CGPointMake(10, 430);
                _mapView.scaleOrigin = CGPointMake(180, 430);
            } else {
                self.info.center = CGPointMake(160, 605);
                _mapView.compassOrigin = CGPointMake(10, 515);
                _mapView.scaleOrigin = CGPointMake(180, 515);
            }

        }
        
    } completion:^(BOOL finished) {
        
        if (self.info) {
            [self.info removeFromSuperview];
            self.info = nil;
        }
        
    }];
}

- (void)pushViewControllerDL{
    ZCViewController_DL *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ZCViewController_DL"];
    vc.currentDevis3_5Inch = self.currentDevis3_5Inch;
    [self.navigationController pushViewController:vc animated:true];
}

- (void)test{
    NSString *pwd = [[NSUserDefaults standardUserDefaults]objectForKey:@"dr_pwd"];
    NSLog(@"Root_test_pwd=%@",pwd);
    /*
     //获取屏幕bounds
    CGRect rect = [[UIScreen mainScreen]bounds];
    CGSize size = rect.size;
    CGFloat width = size.width;
    CGFloat height = size.height;
    NSLog(@"ZCViewController_Root_test_width=%f\nZCViewController_Root_test_height=%f\n",width,height);
    //获取屏幕currentMode
    CGFloat _width = [[UIScreen mainScreen] currentMode].size.width;
    CGFloat _height = [[UIScreen mainScreen] currentMode].size.height;
    NSLog(@"ZCViewController_Root_test_c_width=%f\nZCViewController_Root_test_c_height=%f\n",_width,_height);
     
    NSUserDefaults *userDefault = [[NSUserDefaults standardUserDefaults]init];
    NSString *userID = [userDefault objectForKey:@"userID"];
    NSLog(@"ZCViewController_Root_test_userID=%@",userID);
    */
}

- (BOOL)is3_5Inch{
    CGFloat height = [[UIScreen mainScreen]bounds].size.height;
    if (height == 480) {
        return true;
    }
    return false;
}

- (void)imageLogoAndNameLabTapAction{
    
        ZCViewController_DL *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ZCViewController_DL"];
        [self.navigationController pushViewController:vc animated:true];
    
    
}

- (void)getDataFromUserDefault{
    //NSLog(@"Root_getDataFromUserDefault");
    NSUserDefaults *userDefault = [[NSUserDefaults standardUserDefaults]init];
    NSString *status_Login = [userDefault objectForKey:@"isLogin"];
    if ([status_Login isEqualToString:@"YES"]) {
        
        //self.infoDic = [userDefault dictionaryForKey:@"infoDic"];
        [self getInfoDicFromServer];
        self.isLogin = YES;
    }
}
- (void)getInfoDicFromServer{
    NSData *resultData = nil;
    HttpController *httpController = [[HttpController alloc]init];
    
    NSString *type = @"POST";
    NSString *url = @"app/login/";
    NSString *tel = [[NSUserDefaults standardUserDefaults]objectForKey:@"dr_tel"];
    NSString *pwd = [[NSUserDefaults standardUserDefaults]objectForKey:@"dr_pwd"];
    //NSLog(@"Root_getInfoDicFromServer_pwd=%@",pwd);
    NSString *info = [NSString stringWithFormat:@"dr_tel=%@&dr_pwd=%@",tel,pwd];
    
    resultData = [httpController httpHandleWithType:type url:url info:info];
    
    //NSString *responseString = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    //NSLog(@"ZCViewController_DL_responseString:%@",responseString);
    
    NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error:nil];
    self.infoDic = [resultDic objectForKey:@"data"];
    
}



- (void)searchReGeocode{
    //self.aMapSearch.delegate = self;
    //NSLog(@"ZCViewController_Root_searchReGeocode_latitude=%f_longitude=%f",self._latitude_,self._longitude_);
    AMapReGeocodeSearchRequest *regeoRequest = [[AMapReGeocodeSearchRequest alloc] init];
    //regeoRequest.searchType = AMapSearchType_ReGeocode;
    //regeoRequest.location = [AMapGeoPoint locationWithLatitude:self._latitude_ longitude:self._longitude_];
    regeoRequest.location = [AMapGeoPoint locationWithLatitude:self._latitude_ longitude:self._longitude_];
    //regeoRequest.radius = 10000;
    //regeoRequest.requireExtension = NO;
    
    [self.search AMapReGoecodeSearch: regeoRequest];
    
    
}
/*
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    NSString *result = [NSString stringWithFormat:@"ReGeocode: %@", response.regeocode];
    NSLog(@"ZCViewController_Root_ReGeo: %@", result);
}
*/
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{
    NSString *result = [NSString stringWithFormat:@"%@",response.regeocode.formattedAddress];
    self.address = result;
    //NSLog(@"ReGeo: %@",result);
    //ReGeo: ReGeocode: {address: addressComponent: {province: city: district: township: neighborhood: building: citycode: adcode: streetNumber: {street: number: location: {0.000000 0.000000} distance: 0 direction: }} roads: [] roadinters: [] pois: []}
    
}

- (void)search:(id)searchRequest error:(NSString*)errInfo{
    NSLog(@"ZCViewController_Root_searchRequest_error%@",errInfo);
}


- (void)mapSearchConfig{
    self.search = [[AMapSearchAPI alloc]initWithSearchKey:@"972d0eea5c006b8f06caf09eb2c8f85a" Delegate:self];
}

- (void)locUpdate{
    [self.locationManger startUpdatingLocation];//1分钟1次 查询一次关闭
}
@end

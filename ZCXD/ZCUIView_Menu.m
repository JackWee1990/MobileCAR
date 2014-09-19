//
//  ZCUIView_Menu.m
//  ZCXD
//
//  Created by JackWee on 14-8-8.
//  Copyright (c) 2014年 JackWee. All rights reserved.
//

#import "ZCUIView_Menu.h"


@implementation ZCUIView_Menu

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}

- (instancetype)initWithFrame:(CGRect)frame {
    _arr = [NSArray arrayWithObjects:@"个人信息",@"车辆信息",@"我的订单",@"设置", nil];
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_arr count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPat {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_menu"];
    cell.textLabel.text = _arr[indexPat.row];
    return cell;
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    //_arr = [NSArray arrayWithObjects:@"个人信息",@"车辆信息",@"我的订单",@"设置", nil];
    self.imageview_tx = [[UIImageView alloc] init];
    
    return self;
}
@end

//
//  ZCAnnotationMake.h
//  ZCXD
//
//  Created by JackWee on 14-8-15.
//  Copyright (c) 2014年 JackWee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
@interface ZCAnnotationMake : NSObject<MAAnnotation>
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, assign) NSString *or_id;
@property (nonatomic, strong) NSString *or_title;
@property (nonatomic, strong) NSString *or_start;
@property (nonatomic, strong) NSString *or_end;
//构造函数
- (id)initWithCoordinate:(CLLocationCoordinate2D) coordinate;
//判断该MAAnnotation的坐标与给定坐标是否相等
- (BOOL)hasSomeCoordinateWith:(CLLocationCoordinate2D) coordinate;
@end

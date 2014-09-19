//
//  ZCAnnotationMake.m
//  ZCXD
//
//  Created by JackWee on 14-8-15.
//  Copyright (c) 2014年 JackWee. All rights reserved.
//

#import "ZCAnnotationMake.h"

@implementation ZCAnnotationMake
@synthesize coordinate = _coordinate;

- (id)initWithCoordinate:(CLLocationCoordinate2D) coordinate {
    
    if (self = [super init]) {
        self.coordinate = coordinate;
    }
    return self;
}
/*
- (CLLocationCoordinate2D)coordinate {
    return _coordinate;
}
*/
- (BOOL)hasSomeCoordinateWith:(CLLocationCoordinate2D) coordinate {
    if ((self.coordinate.latitude == coordinate.latitude)&&
       (self.coordinate.longitude == coordinate.longitude))
    {
        return true;
    } else {
        return false;
    }
    //return false;
}
@end

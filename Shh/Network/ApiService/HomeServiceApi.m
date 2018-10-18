//
//  HomeServiceApi.m
//  Shh
//
//  Created by 燕来秋mac9 on 2018/10/18.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "HomeServiceApi.h"

@implementation HomeServiceApi
+ (instancetype)share {
    static HomeServiceApi *global;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (global == nil) {
            global = [[HomeServiceApi alloc] init];
        }
    });
    return global;
}





@end

//
//  CourseHeadView.m
//  Shh
//
//  Created by dnaer7 on 2018/10/23.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "CourseHeadView.h"

@implementation CourseHeadView

-(ZSCycleScrollView *)cycleView{
    if (!_cycleView) {
        _cycleView = [[ZSCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 169)];
        _cycleView.delegate = self;
        _cycleView.autoScrollTimeInterval = 3.0;
        _cycleView.dotColor = [UIColor whiteColor];
        //        NSArray *images = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"bg_mine"],[UIImage imageNamed:@"bg_mine"],[UIImage imageNamed:@"bg_mine"],[UIImage imageNamed:@"bg_mine"],nil];
        //        _cycleView.localImageGroups = images;
    }
    return _cycleView;
}

@end

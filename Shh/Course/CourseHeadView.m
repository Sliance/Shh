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
        _cycleView = [[ZSCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 200*SCREENWIDTH/375)];
        _cycleView.delegate = self;
        _cycleView.autoScrollTimeInterval = 3.0;
        _cycleView.dotColor = [UIColor whiteColor];
    }
    return _cycleView;
}
-(ZSSortSelectorView *)selectorView{
    if (!_selectorView) {
        _selectorView = [[ZSSortSelectorView alloc]initWithFrame:CGRectMake(0,  200*SCREENWIDTH/375, SCREENWIDTH, 40)];
        _selectorView.delegate = self;
        
    }
    return _selectorView;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.cycleView];
        [self addSubview:self.selectorView];
    }
    return self;
}
-(void)chooseButtonType:(NSInteger)type{
    self.selectedBlock(type);
}
@end

//
//  ServiceHeadView.m
//  Shh
//
//  Created by 燕来秋mac9 on 2018/8/29.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "ServiceHeadView.h"

@implementation ServiceHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.cycleView];
        [self addSubview:self.memberBtn];
        [self.cycleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.height.mas_equalTo(200*SCREENWIDTH/375);
        }];
        [self.memberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.top.equalTo(self.cycleView.mas_bottom).offset(15);
            make.height.mas_equalTo(40);
        }];
    }
    return self;
}
-(ZSCycleScrollView *)cycleView{
    if (!_cycleView) {
        _cycleView = [[ZSCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 170)];
        _cycleView.delegate = self;
        _cycleView.autoScrollTimeInterval = 3.0;
        _cycleView.dotColor = [UIColor whiteColor];
    }
    return _cycleView;
}
-(UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc]init];
        _topView.backgroundColor = DSColorFromHex(0xDCDCDC);
    }
    return _topView;
}
-(UIButton *)memberBtn{
    if (!_memberBtn) {
        _memberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _memberBtn.backgroundColor = DSColorFromHex(0xE70019);
        [_memberBtn setTitle:@"加入研习社" forState:UIControlStateNormal];
        [_memberBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _memberBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_memberBtn.layer setCornerRadius:2];
        [_memberBtn.layer setMasksToBounds:YES];
    }
    return _memberBtn;
}
@end

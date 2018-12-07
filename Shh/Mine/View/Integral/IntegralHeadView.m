//
//  IntegralHeadView.m
//  Shh
//
//  Created by zhangshu on 2018/12/7.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "IntegralHeadView.h"

@implementation IntegralHeadView
-(ZSSortSelectorView *)selectorView{
    if (!_selectorView) {
        _selectorView = [[ZSSortSelectorView alloc]initWithFrame:CGRectMake(0, 180*SCREENWIDTH/375, SCREENWIDTH, 50)];
        _selectorView.delegate = self;
        
    }
    return _selectorView;
}
-(UIImageView *)bgImage{
    if (!_bgImage) {
        _bgImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bgface"]];
        _bgImage.userInteractionEnabled = YES;
        _bgImage.frame = CGRectMake(0, 0, SCREENWIDTH, 180*SCREENWIDTH/375);
    }
    return _bgImage;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, SCREENWIDTH, 40)];
        _titleLabel.text = @"7";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont boldSystemFontOfSize:40];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 90, SCREENWIDTH, 20)];
        _contentLabel.text = @"积分0";
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textColor = [UIColor whiteColor];
    }
    return _contentLabel;
}
-(UIButton *)shareBtn{
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setTitle:@"推广大使" forState:UIControlStateNormal];
        _shareBtn.frame = CGRectMake(SCREENWIDTH/2-50, 130, 100, 40);
        _shareBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_shareBtn.layer setBorderWidth:1];
        [_shareBtn.layer setBorderColor:[UIColor whiteColor].CGColor];
        [_shareBtn.layer setCornerRadius:4];
        [_shareBtn addTarget:self action:@selector(pressShare) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgImage];
        [self addSubview:self.selectorView];
        [self.bgImage addSubview:self.titleLabel];
        [self.bgImage addSubview:self.contentLabel];
        [self.bgImage addSubview:self.shareBtn];
        [self.selectorView setDataArr:@[@"积分明细",@"我的任务",@"排行榜"]];
        [self.selectorView setCurrentPage:0];
    }
    return self;
}
-(void)chooseButtonType:(NSInteger)type{
    self.chooseBlock(type);
}
-(void)pressShare{
    self.shareBlock();
}

@end

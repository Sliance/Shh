//
//  HomeHeadView.m
//  Shh
//
//  Created by 燕来秋mac9 on 2018/8/24.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "HomeHeadView.h"

@implementation HomeHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setCortentLayout];
        self.backgroundColor = DSColorFromHex(0xF5F5F5);
    }
    return self;
}
-(void)setCortentLayout{
    NSArray *imageArr= @[@"\U0000e91e",@"\U0000e91f",@"\U0000e90e",@"\U0000e8f0",@"\U0000e905"];
    NSArray *dataArr = @[@"干货头条",@"团队打造",@"金牌店长",@"微信营销",@"更多分类"];
    for (int i = 0; i<5; i++) {
        MineTypeBtn *btn = [[MineTypeBtn alloc]initWithFrame:CGRectMake(i*SCREENWIDTH/5, 169, SCREENWIDTH/5, 88)];
        btn.imageLabel.text = imageArr[i];
        btn.typeLabel.text = dataArr[i];
        btn.tag = i;
        btn.backgroundColor = [UIColor whiteColor];
        btn.imageLabel.textColor = DSColorFromHex(0x464646);
        btn.typeLabel.textColor = DSColorFromHex(0x464646);
        [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    [self addSubview:self.bgView];
    [self addSubview:self.cycleView];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.rightLabel];
    [self.bgView addSubview:self.allBtn];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(50);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(15);
        make.centerY.equalTo(self.bgView);
    }];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-15);
        make.centerY.equalTo(self.bgView);
        make.width.mas_equalTo(12);
        make.height.mas_equalTo(12);
    }];
    [self.allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightLabel.mas_left);
        make.top.equalTo(self.bgView);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(50);
    }];
}
-(UIView *)bgView{
    if(!_bgView){
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.textColor = DSColorFromHex(0x474747);
        _titleLabel.text = @"限时免费";
    }
    return _titleLabel;
}
- (UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.font = [UIFont fontWithName:@"icomoon"size:12];
        _rightLabel.text = @"\U0000e90d";
        _rightLabel.textColor = DSColorFromHex(0x787878);
    }
    return _rightLabel;
}
-(UIButton *)allBtn{
    if (!_allBtn) {
        _allBtn.backgroundColor = [UIColor redColor];
        _allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allBtn setTitle:@"全部" forState:UIControlStateNormal];
        [_allBtn setTitleColor:DSColorFromHex(0x787878) forState:UIControlStateNormal];
        _allBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_allBtn addTarget:self action:@selector(pressAll:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _allBtn;
}
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
-(void)pressBtn:(MineTypeBtn*)sender{
    self.selectedBlock(sender.tag);
}
-(void)pressAll:(UIButton*)sender{
    self.allBlock();
}
@end

//
//  HomeFreeHeadView.m
//  Shh
//
//  Created by 燕来秋mac9 on 2018/8/28.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "HomeFreeHeadView.h"

@implementation HomeFreeHeadView

-(instancetype)init{
    self = [super init];
    if (self) {

        [self addSubview:self.bgView];
        [self.bgView addSubview:self.titleLabel];
        [self.bgView addSubview:self.rightLabel];
        [self.bgView addSubview:self.allBtn];
        self.bgView.frame = CGRectMake(0, 5, SCREENWIDTH, 50);
        self.titleLabel.frame = CGRectMake(15, 0, SCREENWIDTH-15, 50);
        self.backgroundColor = DSColorFromHex(0xF5F5F5);
    }
    return self;
}
-(void)setCortentLayout{
    
    self.allBtn.frame = CGRectMake(SCREENWIDTH-65, 0, 40, 50);
    self.rightLabel.frame = CGRectMake(SCREENWIDTH-23, 0, 12, 50);
    
}
-(void)likeLayout{
    self.allBtn.frame = CGRectMake(SCREENWIDTH-55, 0, 50, 50);
    self.rightLabel.frame = CGRectMake(SCREENWIDTH-72, 0, 12, 50);
   
}
-(void)setTitle:(NSString *)title{
    self.titleLabel.text = title;
    if ([title isEqualToString:@"猜你喜欢"]) {
        [self likeLayout];
    }else{
         [self setCortentLayout];
    }
    
    
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
        _titleLabel.text = @"";
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
-(void)pressAll:(UIButton*)sender{
    self.allBlock();
}
@end

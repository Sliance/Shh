//
//  NavigationView.m
//  Shh
//
//  Created by 燕来秋mac9 on 2018/8/29.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "NavigationView.h"

@implementation NavigationView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.searchBtn];
        [self addSubview:self.historyBtn];
        [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.bottom.equalTo(self).offset(-8);
            make.right.equalTo(self).offset(-45);
            make.height.mas_equalTo(30);
        }];
        [self.historyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.searchBtn);
            make.right.equalTo(self).offset(-15);
            make.height.width.mas_equalTo(22);
        }];
    }
    return self;
}

-(UIButton *)searchBtn{
    if (!_searchBtn) {
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchBtn setImage:[UIImage imageNamed:@"search_home"] forState:UIControlStateNormal];
        [_searchBtn setTitle:@"搜索课程" forState:UIControlStateNormal];
        _searchBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_searchBtn setTitleColor:DSColorFromHex(0x959595) forState:UIControlStateNormal];
        _searchBtn.frame = CGRectMake(15, 5, SCREENWIDTH-60, 36);
        _searchBtn.backgroundColor = DSColorFromHex(0xF0F0F0);
        _searchBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, SCREENWIDTH/2+30);
        _searchBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, SCREENWIDTH/2);
        [_searchBtn.layer setCornerRadius:15];
        [_searchBtn.layer setMasksToBounds:YES];
    }
    return _searchBtn;
}
-(UIButton *)historyBtn{
    if (!_historyBtn) {
        _historyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_historyBtn setTitle:@"\U0000e913" forState:UIControlStateNormal];
        _historyBtn.titleLabel.font = [UIFont fontWithName:@"icomoon"size:22];
        [_historyBtn setTitleColor:DSColorFromHex(0x464646) forState:UIControlStateNormal];
    }
    return _historyBtn;
}
@end

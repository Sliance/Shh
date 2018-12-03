//
//  SearchHeadView.m
//  Shh
//
//  Created by zhangshu on 2018/12/3.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "SearchHeadView.h"

@implementation SearchHeadView

-(UITextField *)searchField{
    if (!_searchField) {
        _searchField = [[UITextField alloc]init];
        _searchField.delegate = self;
        _searchField.placeholder = @"输入搜索的内容";
        _searchField.font = [UIFont systemFontOfSize:15];
        [_searchField.layer setCornerRadius:15];
        _searchField.backgroundColor = DSColorFromHex(0xF0F0F0);
        [_searchField.layer setMasksToBounds:YES];
        _searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchField.returnKeyType = UIReturnKeySearch;
    }
    return _searchField;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = DSColorFromHex(0x464646);
        _titleLabel.text = @"热门搜索";
    }
    return _titleLabel;
}
-(UILabel *)line{
    if (!_line) {
        _line = [[UILabel alloc]init];
        _line.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _line;
}
-(UILabel *)line1{
    if (!_line1) {
        _line1 = [[UILabel alloc]init];
        _line1.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _line1;
}
-(UIButton *)cancleBtn{
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleBtn setTitleColor:DSColorFromHex(0x464646) forState:UIControlStateNormal];
        [_cancleBtn addTarget:self action:@selector(pressesCancLe) forControlEvents:UIControlEventTouchUpInside];
        _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _cancleBtn;
}
-(void)pressesCancLe{
    self.cancleBlock();
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.searchField];
//        [self addSubview:self.line1];
        [self addSubview:self.line];
        [self addSubview:self.cancleBtn];
//        [self addSubview:self.titleLabel];
        [self.searchField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(self).offset(5);
            make.height.mas_equalTo(30);
            make.right.equalTo(self).offset(-60);
        }];
        [self.cancleBtn  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(50);
            make.centerY.equalTo(self.searchField);
        }];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self).offset(0);
            make.top.equalTo(self.searchField.mas_bottom).offset(5);
            make.height.mas_equalTo(5);
        }];
//        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self).offset(15);
//            make.top.equalTo(self.line.mas_bottom).offset(0);
//            make.height.mas_equalTo(45);
//        }];
//        [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.equalTo(self).offset(0);
//            make.top.equalTo(self.titleLabel.mas_bottom).offset(-1);
//            make.height.mas_equalTo(0.5);
//        }];
        
    }
    return self;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        self.endBlock(self.searchField.text);
        [self.searchField resignFirstResponder];
    }else{
        
    }
    return YES;
}

@end

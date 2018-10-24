//
//  ZSSortSelectorView.m
//  ZSSortSelectorView
//
//  Created by 燕来秋mac9 on 2018/6/15.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "ZSSortSelectorView.h"
#import "ZSScrollButton.h"

@interface ZSSortSelectorView ()<ZSSortSelectorViewDelegate,ZSScrollButtonDelegate>
{
    CGFloat _width;
    CGFloat _height;
}
@property (nonatomic , strong) UIScrollView *mainView;

@property (nonatomic , strong) UIButton *leftBtn;





@property (nonatomic , strong) NSMutableArray *buttonArr;



@end

@implementation ZSSortSelectorView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _width = frame.size.width;
        _height = frame.size.height-1;
        self.backgroundColor =[UIColor whiteColor];
        _buttonArr = [NSMutableArray array];
       
        [self initView];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.mainView];
    [self addSubview:self.lineLabel];
//    [self addSubview:self.leftBtn];
//    [self addSubview:self.rightBtn];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
}
-(UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = DSColorFromHex(0xE6E6E6);
    }
    return _lineLabel;
}
- (void)setDataArr:(NSArray *)dataArr {
    _dataArr =dataArr;
    [_buttonArr removeAllObjects];
    for (UIView *view in _mainView.subviews) {
        if ([view isKindOfClass:[ZSScrollButton class]]) {
            [view removeFromSuperview];
        }
    }
    _mainView.contentSize = CGSizeMake(_dataArr.count*80+80, _height);
    for (int i=0; i<_dataArr.count; i++) {
        ZSScrollButton *btn = [[ZSScrollButton alloc]initWithFrame:CGRectMake(i*80, 0, 80, _height) miantitle:dataArr[i] count:[NSString stringWithFormat:@"33"]];
        btn.tag = i+33;
        if (!i) {
            [btn changeStatus:YES];
        }
        btn.delegate = self;
        [_buttonArr addObject:btn];
        [_mainView addSubview:btn];
    }
}

#pragma mark lazy_load
- (UIScrollView *)mainView {
    if (!_mainView) {
        _mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _width, _height)];
        _mainView.showsVerticalScrollIndicator = NO;
        _mainView.showsHorizontalScrollIndicator = NO;
        _mainView.scrollEnabled = YES;
        _mainView.bounces = YES;
        
    }
    return _mainView;
}

- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, _height)];
        _leftBtn.backgroundColor = [UIColor lightGrayColor];
        [_leftBtn addTarget:self action:@selector(decrease) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(_width-40, 0, 40, _height)];
        [_rightBtn setImage:[UIImage imageNamed:@"down_icon"] forState:UIControlStateNormal];
        [_rightBtn setImage:[UIImage imageNamed:@"up_icon"] forState:UIControlStateSelected];
        [_rightBtn addTarget:self action:@selector(increase:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

#pragma mark 方法
- (void)decrease {
    if (_currentPage>0) {
        _currentPage--;
        [self updateStatus];
    }
    
}
-(void)setCurrentPage:(NSInteger)currentPage{
    _currentPage = currentPage;
    [self updateStatus];
}

- (void)increase:(UIButton*)sender{
//    if (_currentPage<_dataArr.count-1) {
//        _currentPage++;
//        [self updateStatus];
//    }
    sender.selected = !sender.selected;
    self.selectedBlock(sender.selected);
}

- (void)updateStatus {
    for (ZSScrollButton *btn in _buttonArr) {
        if (btn.tag == _currentPage+33) {
            [btn changeStatus:YES];
        }else{
            [btn changeStatus:NO];
        }
    }

    if (_currentPage>=0&&_currentPage<_dataArr.count-2) {
        CGFloat current =_currentPage*80;
//        _mainView.contentOffset = CGPointMake(current, 0);
    }
    
}

#pragma mark 代理
- (void)selectedButton:(NSInteger)sender {
    for (ZSScrollButton *btn in _buttonArr) {
        if (sender == btn.tag) {
            [btn changeStatus:YES];
        }else{
            [btn changeStatus:NO];
        }
    }
    _currentPage = sender-33;
    if ([self.delegate respondsToSelector:@selector(chooseButtonType:)]) {
        [self.delegate chooseButtonType:_currentPage];
    }
    
}

@end

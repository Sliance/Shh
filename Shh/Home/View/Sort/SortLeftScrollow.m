//
//  SortLeftScrollow.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/20.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "SortLeftScrollow.h"
#import "SortBtn.h"
@interface SortLeftScrollow()<UIScrollViewDelegate>

@end
@implementation SortLeftScrollow

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgScrollow];
    }
    return self;
}
-(UIScrollView *)bgScrollow{
    if (!_bgScrollow) {
        _bgScrollow = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,80, self.frame.size.height)];
        _bgScrollow.delegate = self;
        _bgScrollow.showsHorizontalScrollIndicator = NO;
        _bgScrollow.showsVerticalScrollIndicator = NO;
        _bgScrollow.backgroundColor = DSColorFromHex(0xFAFAFA);
        
    }
    return _bgScrollow;
}
-(void)setDataArr:(NSMutableArray *)dataArr{
    _dataArr = dataArr;
    for (int i = 0; i < dataArr.count; i++) {
       SortBtn* btn = [[SortBtn alloc]initWithFrame:CGRectMake( 0, 54*i, 80, 54)];
        if (i ==0) {
            btn.selectedLabel.hidden = NO;
            btn.backgroundColor = DSColorFromHex(0xFAFAFA);
            btn.sortLabel.textColor = DSColorFromHex(0xE70019);
            _tmpBtn = btn;
        }else{
            btn.sortLabel.textColor = DSColorFromHex(0x464646);
            btn.backgroundColor = DSColorFromHex(0xFAFAFA);
            btn.selectedLabel.hidden = YES;
            
        }
        [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.sortLabel.text = dataArr[i];
        btn.tag = i+100;
        [self.bgScrollow addSubview:btn];
        _bgScrollow.contentSize = CGSizeMake(0, 54*dataArr.count+10);
    }
}

-(void)pressBtn:(SortBtn*)sender{

    if (_tmpBtn == nil){
        sender.selected = YES;
        sender.selectedLabel.hidden = NO;
        sender.backgroundColor = [UIColor whiteColor];
        sender.sortLabel.textColor = DSColorFromHex(0xE70019);
        _tmpBtn = sender;
    }else if (_tmpBtn !=nil && _tmpBtn == sender){
        sender.selected = YES;
        sender.selectedLabel.hidden = NO;
        
        sender.sortLabel.textColor = DSColorFromHex(0xE70019);
    }else if (_tmpBtn!= sender && _tmpBtn!=nil){
        _tmpBtn.selected = NO;
        _tmpBtn.selectedLabel.hidden = YES;
        _tmpBtn.sortLabel.textColor = DSColorFromHex(0x464646);
        
        sender.selected = YES;
        sender.selectedLabel.hidden = NO;
        sender.backgroundColor = [UIColor whiteColor];
        sender.sortLabel.textColor = DSColorFromHex(0xE70019);
        _tmpBtn = sender;
    }
    if ([self.delegate respondsToSelector:@selector(selectedSortIndex:)]) {
        [self.delegate selectedSortIndex:sender.tag-100];
    }
}
@end

//
//  MoreButtonScrollView.m
//  KeyBoard
//
//  Created by ShaoFeng on 16/8/18.
//  Copyright © 2016年 Cocav. All rights reserved.
//
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#import "MoreButtonView.h"
#import "ZSConfig.h"
@interface MoreButtonView ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *bgscrollow;

@end

@implementation MoreButtonView
-(UIScrollView *)bgscrollow{
    if (!_bgscrollow) {
        _bgscrollow = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 200)];
        _bgscrollow.contentSize = CGSizeMake(SCREENWIDTH*2, 0);
        _bgscrollow.pagingEnabled = YES;
        _bgscrollow.delegate = self;
    }
    return _bgscrollow;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        self.backgroundColor = [UIColor colorWithRed:243 / 255.0 green:243 / 255.0 blue:243 / 255.0 alpha:1];
        
        [self addSubview:self.bgscrollow];
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(-20, 180, 40, 40)];
        pageControl.numberOfPages = 2;
        pageControl.currentPage = 0;
        pageControl.currentPageIndicatorTintColor = DSColorFromHex(0xC8C8C8);
        pageControl.pageIndicatorTintColor = DSColorFromHex(0xE6E6E6);
//        pageControl.hidesForSinglePage = YES;
        [pageControl updateCurrentPageDisplay];
        [self addSubview:pageControl];
        [self layoutUI];
    }
    return self;
}

- (void)layoutUI
{
    [self addButtonWithIcon:@"photo_keyboard" highIcon:@"photo_keyboard" tag:MoreButtonViewButtonTypeImages title:@"相册"];
    [self addButtonWithIcon:@"shoot_keyboard" highIcon:@"shoot_keyboard" tag:MoreButtonViewButtonTypeCamera title:@"拍摄"];
    [self addButtonWithIcon:@"vedio_keyboard" highIcon:@"vedio_keyboard" tag:MoreButtonViewButtonTypeFile title:@"视频聊天"];
    [self addButtonWithIcon:@"encrypt_keyboard" highIcon:@"encrypt_keyboard" tag:MoreButtonViewButtonTypeContact title:@"加密聊天"];
    [self addButtonWithIcon:@"D_keyboard" highIcon:@"D_keyboard" tag:MoreButtonViewButtonTypeLocation title:@"DNAER币"];
    [self addButtonWithIcon:@"red_keyboard" highIcon:@"red_keyboard" tag:MoreButtonViewButtonTypeSeal title:@"红包"];
    [self addButtonWithIcon:@"transfer_keyboard" highIcon:@"transfer_keyboard" tag:MoreButtonViewButtonTypeEmail title:@"转账"];
     [self addButtonWithIcon:@"bum_keyboard" highIcon:@"bum_keyboard" tag:MoreButtonViewButtonTypeEmail title:@"阅后即焚"];
    [self addButtonWithIcon:@"collection_message" highIcon:@"collection_message" tag:MoreButtonViewButtonTypeSeal title:@"我的收藏"];
    [self addButtonWithIcon:@"like_message" highIcon:@"like_message" tag:MoreButtonViewButtonTypeEmail title:@"我喜欢的"];
    [self addButtonWithIcon:@"file_message" highIcon:@"file_message" tag:MoreButtonViewButtonTypeEmail title:@"文件"];
    [self addButtonWithIcon:@"card_message" highIcon:@"card_message" tag:MoreButtonViewButtonTypeEmail title:@"名片"];
    [self addButtonWithIcon:@"location_message" highIcon:@"location_message" tag:MoreButtonViewButtonTypeEmail title:@"位置"];
    
}

- (void)addButtonWithIcon:(NSString *)icon highIcon:(NSString *)heighIcon tag:(int )tag title:(NSString *)title
{
    UIButton *button = [[UIButton alloc] init];
    button.tag = tag;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:heighIcon] forState:UIControlStateNormal];
    [self.bgscrollow addSubview:button];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = DSColorFromHex(0x969696);
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    [self.bgscrollow addSubview:label];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSMutableArray *mArrayButton = [NSMutableArray array];
    NSMutableArray *mArrayLabel = [NSMutableArray array];

    for (UIView *view in self.bgscrollow.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [mArrayButton addObject:view];
        } else if ([view isKindOfClass:[UILabel class]]) {
            [mArrayLabel addObject:view];
        }
    }
    
    CGFloat buttonW = 55;
    CGFloat buttonH = buttonW;
    for (NSInteger i = 0; i < mArrayButton.count; i ++) {
        if (i>7) {
            
            UIButton *button = mArrayButton[i];
            UILabel *label = [mArrayLabel objectAtIndex:i];
            CGFloat X = (((SCREEN_WIDTH - (4 * buttonW)) / 5) * ((i % 4) + 1)) + (buttonW * (i % 4))+SCREENWIDTH;
            CGFloat Y = 15 + ((i-8) / 4) * (buttonH + 35);
            button.frame = CGRectMake(X, Y, buttonW, buttonH);
            label.frame = CGRectMake(button.frame.origin.x, CGRectGetMaxY(button.frame) + 3, button.frame.size.width + 5, 20);
        }else{
            UIButton *button = mArrayButton[i];
            UILabel *label = [mArrayLabel objectAtIndex:i];
            CGFloat X = (((SCREEN_WIDTH - (4 * buttonW)) / 5) * ((i % 4) + 1)) + (buttonW * (i % 4));
            CGFloat Y = 15 + (i / 4) * (buttonH + 35);
            button.frame = CGRectMake(X, Y, buttonW, buttonH);
            label.frame = CGRectMake(button.frame.origin.x, CGRectGetMaxY(button.frame) + 3, button.frame.size.width + 5, 20);
        }
    }
}

- (void)buttonClick:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(moreButtonView:didClickButton:)]) {
        [_delegate moreButtonView:self didClickButton:(MoreButtonViewButtonType)sender.tag];
    }
}

@end

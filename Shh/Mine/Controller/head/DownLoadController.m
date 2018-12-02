//
//  DownLoadController.m
//  Shh
//
//  Created by 张舒 on 2018/12/1.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "DownLoadController.h"
#import "FinshDownController.h"
#import "DownLoadingController.h"
#import "KKClassificationView.h"

@interface DownLoadController ()
@property (nonatomic, strong) NSArray *titleArr;
@property(strong, nonatomic) KKClassiflcationLayout *layout;
@property(strong, nonatomic) KKClassificationView *managerView;
@property(copy, nonatomic) NSMutableArray *viewControllers;

@end

@implementation DownLoadController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.managerView];
}


#pragma mark - 懒加载
-(KKClassificationView *)managerView
{
    if (!_managerView) {
        _managerView = [[KKClassificationView alloc]initWithFrame:CGRectMake(0,[self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT-[self navHeightWithHeight]) viewController:self layout:self.layout clickBlock:^(NSInteger index) {
            
        }];
    }
    return _managerView;
}

-(KKClassiflcationLayout *)layout
{
    if (!_layout) {
        _layout = [[KKClassiflcationLayout alloc] init];
        _layout.isAverage = YES;
        _layout.titleViewBgColor = [UIColor whiteColor];
        _layout.lrMargin = 20;
        //控制滑块高度
        _layout.sliderHeight = 44;
        _layout.titleMargin = 10;
        _layout.titleSelectColor = DSColorFromHex(0xE70019);
        _layout.titleColor = DSColorFromHex(0x969696);
        _layout.titleFont = [UIFont systemFontOfSize:16];
        _layout.titleSelectFont = [UIFont boldSystemFontOfSize:16];
        _layout.titles = self.titleArr;
        _layout.viewControllers = self.viewControllers;
        _layout.LinkColor = DSColorFromHex(0xDCDCDC);
        _layout.linkHeight = 0.5;
        _layout.bottomLineHeight = 2;
        _layout.bottomLineWidth = 30;
        _layout.bottomLineColor =DSColorFromHex(0xE70019);
    }
    return _layout;
}

- (NSArray *)titleArr
{
    if (!_titleArr) {
        _titleArr = @[@"已完成",@"下载中"];
    }
    return _titleArr;
}

- (NSMutableArray *)viewControllers
{
    if (!_viewControllers) {
        _viewControllers = [[NSMutableArray alloc]init];
        FinshDownController *friendvc = [[FinshDownController alloc]init];
        [_viewControllers addObject:friendvc];
        DownLoadingController *attentionvc = [[DownLoadingController alloc]init];
        [_viewControllers addObject:attentionvc];
        
    }
    return _viewControllers;
}


-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = DSColorFromHex(0xF0F0F0);
        [self setTitle:@"我的下载"];
        
    }
    return self;
}

@end

//
//  HistoryBaseController.m
//  Shh
//
//  Created by 张舒 on 2018/12/1.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "HistoryBaseController.h"
#import "KKClassificationView.h"
#import "HistoryArticleController.h"
#import "HistoryCourseController.h"
#import "MineServiceApi.h"
@interface HistoryBaseController ()
@property (nonatomic, strong)HistoryCourseController *friendvc;
@property (nonatomic, strong)HistoryArticleController *attentionvc;
@property (nonatomic, strong) NSArray *titleArr;
@property(strong, nonatomic) KKClassiflcationLayout *layout;
@property(strong, nonatomic) KKClassificationView *managerView;
@property(copy, nonatomic) NSMutableArray *viewControllers;
@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation HistoryBaseController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = DSColorFromHex(0xF0F0F0);
        [self setTitle:@"历史记录"];
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [[NSMutableArray alloc]init];
    [self.view addSubview:self.managerView];
}
#pragma mark - 懒加载
-(KKClassificationView *)managerView
{
    if (!_managerView) {
        _managerView = [[KKClassificationView alloc]initWithFrame:CGRectMake(0,[self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT-[self navHeightWithHeight]) viewController:self layout:self.layout clickBlock:^(NSInteger index) {
            
            if (index ==0) {
                [self getFreeListType:@"video"];
            }else if (index ==1){
                [self getFreeListType:@"audio"];
            }
        }];
    }
    return _managerView;
}

-(void)getFreeListType:(NSString*)type{
    FreeListReq *req = [[FreeListReq alloc]init];
    req.appId = @"1041622992853962754";
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.platform = @"ios";
    req.pageIndex = 1;
    req.pageSize = @"100";
    req.memberId = [UserCacheBean share].userInfo.memberId;
    
    __weak typeof(self)weakself = self;
    [[MineServiceApi share]getHistoryListWithParam:req response:^(id response) {
        if (response) {
            [weakself.dataArr removeAllObjects];
            for (FreeListRes *model in response) {
                if ([model.courseVideoOrAudio isEqualToString:type]) {
                    [weakself.dataArr addObject:model];
                }
            }
            if ([type isEqualToString:@"audio"]) {
                [weakself.attentionvc setDataArr:weakself.dataArr];
            }else{
                [weakself.friendvc setDataArr:weakself.dataArr];
            }
        }
        
        
    }];
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
        _titleArr = @[@"视频",@"音频"];
    }
    return _titleArr;
}

- (NSMutableArray *)viewControllers
{
    if (!_viewControllers) {
        _viewControllers = [[NSMutableArray alloc]init];
        _friendvc = [[HistoryCourseController alloc]init];
        [_viewControllers addObject:self.friendvc];
         _attentionvc= [[HistoryArticleController alloc]init];
        [_viewControllers addObject:self.attentionvc];
        
    }
    return _viewControllers;
}

@end

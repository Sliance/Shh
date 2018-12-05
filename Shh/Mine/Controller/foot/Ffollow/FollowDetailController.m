//
//  FollowDetailController.m
//  Shh
//
//  Created by zhangshu on 2018/12/5.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "FollowDetailController.h"
#import "DetailFollowHeadView.h"
#import "MineServiceApi.h"

@interface FollowDetailController ()
@property(nonatomic,strong)DetailFollowHeadView *headView;

@end

@implementation FollowDetailController
-(DetailFollowHeadView *)headView{
    if (!_headView) {
        _headView = [[DetailFollowHeadView alloc]initWithFrame:CGRectMake(0, [self navHeightWithHeight], SCREENWIDTH, 300)];
    }
    return _headView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.headView];
}
-(void)setTeacherMemberId:(NSString *)teacherMemberId{
    _teacherMemberId = teacherMemberId;
    [self requestData];
}
-(void)requestData{
    FreeListReq *req = [[FreeListReq alloc]init];
    req.appId = @"1041622992853962754";
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.platform = @"ios";
    req.pageIndex = 1;
    req.pageSize = @"100";
    req.teacherMemberId = self.teacherMemberId;
    __weak typeof(self)weakself = self;
    [[MineServiceApi share]getTeacherInfoWithParam:req response:^(id response) {
        if (response) {
            [weakself.headView setModel:response];
        }
    }];
}
@end

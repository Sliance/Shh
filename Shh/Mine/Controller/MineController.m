//
//  MineController.m
//  Shh
//
//  Created by 燕来秋mac9 on 2018/8/23.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "MineController.h"
#import "MineHeadView.h"
#import "MineFootView.h"
#import "MessageController.h"
#import "SettingController.h"
#import "PersonInfoController.h"
#import "LoginController.h"
#import "MineServiceApi.h"
#import "HelpCenterController.h"
#import "EnterShhController.h"
#import "HistoryBaseController.h"
#import "CollectionBaseController.h"
#import "DownLoadController.h"
#import "MineFollowController.h"
#import "MinePurchaseController.h"

@interface MineController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *bgscrollow;
@property(nonatomic,strong)MineHeadView *headView;
@property(nonatomic,strong)MineFootView *footView;
@property(nonatomic,strong)MemberInfoRes *result;

@end

@implementation MineController
-(UIScrollView *)bgscrollow{
    if (!_bgscrollow) {
        _bgscrollow = [[UIScrollView alloc]init];
        _bgscrollow.frame = CGRectMake(0,44-[self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT);
        _bgscrollow.delegate = self;
        _bgscrollow.contentSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT+100);
        _bgscrollow.backgroundColor = DSColorFromHex(0xFAFAFA);
    }
    return _bgscrollow;
}
-(MineHeadView *)headView{
    if (!_headView) {
        _headView = [[MineHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 290)];
    }
    return _headView;
}
-(MineFootView *)footView{
    if (!_footView) {
        _footView = [[MineFootView alloc]initWithFrame:CGRectMake(0, 290, SCREENWIDTH, 355)];
    }
    return _footView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.bgscrollow];
    [self.bgscrollow addSubview:self.headView];
    [self.bgscrollow addSubview:self.footView];
    __weak typeof(self)weakself = self;
    [self.headView setMessageBlock:^{
        MessageController *messageVC = [[MessageController alloc]init];
        messageVC.hidesBottomBarWhenPushed = YES;
        [weakself.navigationController pushViewController:messageVC animated:YES];
    }];
    [self.headView setEditBlock:^{
        if ([UserCacheBean share].userInfo.token.length>0) {
            PersonInfoController *infoVC = [[PersonInfoController alloc]init];
            infoVC.hidesBottomBarWhenPushed = YES;
            [weakself.navigationController pushViewController:infoVC animated:YES];
        }else{
            LoginController *loginVC = [[LoginController alloc]init];
            loginVC.hidesBottomBarWhenPushed = YES;
            [weakself.navigationController pushViewController:loginVC animated:YES];
        }
    }];
    [self.headView setTypeBlock:^(NSInteger index) {
        if (index ==1) {
            HistoryBaseController *setVC = [[HistoryBaseController alloc]init];
            setVC.hidesBottomBarWhenPushed = YES;
            [weakself.navigationController pushViewController:setVC animated:YES];
        }else if (index ==2){
            DownLoadController *setVC = [[DownLoadController alloc]init];
            setVC.hidesBottomBarWhenPushed = YES;
            [weakself.navigationController pushViewController:setVC animated:YES];
        }
    }];
    [self.footView setSelecteBlock:^(NSUInteger index) {
        
        switch (index) {
            case 0:
            {
                MinePurchaseController *setVC = [[MinePurchaseController alloc]init];
                setVC.hidesBottomBarWhenPushed = YES;
                [weakself.navigationController pushViewController:setVC animated:YES];
            }
                break;
            case 1:
            {
                CollectionBaseController *setVC = [[CollectionBaseController alloc]init];
                setVC.hidesBottomBarWhenPushed = YES;
                [weakself.navigationController pushViewController:setVC animated:YES];
            }
                break;
            case 2:
            {
                MineFollowController *setVC = [[MineFollowController alloc]init];
                setVC.hidesBottomBarWhenPushed = YES;
                [weakself.navigationController pushViewController:setVC animated:YES];
            }
                break;
            case 3:
            {
                SettingController *setVC = [[SettingController alloc]init];
                setVC.hidesBottomBarWhenPushed = YES;
                [weakself.navigationController pushViewController:setVC animated:YES];
            }
                break;
            case 4:
            {
                EnterShhController *enterVC = [[EnterShhController alloc]init];
                enterVC.hidesBottomBarWhenPushed = YES;
                [weakself.navigationController pushViewController:enterVC animated:YES];
            }
                break;
            case 5:
            {
                    HelpCenterController *helpVC = [[HelpCenterController alloc]init];
                    helpVC.hidesBottomBarWhenPushed = YES;
                    [weakself.navigationController pushViewController:helpVC animated:YES];
             }
                break;
                
            default:
                break;
        }
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    if ([UserCacheBean share].userInfo.token.length>0) {
        [self.headView.editBtn setTitle:[UserCacheBean share].userInfo.memberName forState:UIControlStateNormal];
        [self.headView.editBtn setImage:[UIImage imageNamed:@"edit_mine"] forState:UIControlStateNormal];
        [self.headView.editBtn setIconInRightWithSpacing:7];
        [self requestData];
    }else{
        self.headView.frame = CGRectMake(0, 0, SCREENWIDTH, 290);
        [self.headView.editBtn setTitle:@"未登录" forState:UIControlStateNormal];
        [self.headView.editBtn setImage:nil forState:UIControlStateNormal];
        self.headView.editBtn.imageView.width = 0;
        [self.headView.editBtn setIconInRightWithSpacing:0];
        
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
-(void)requestData{
    LoginReq *req = [[LoginReq alloc]init];
    req.appId = @"1041622992853962754";
    req.timestamp = @"0";
    req.platform = @"ios";
    req.token = [UserCacheBean share].userInfo.token;
    __weak typeof(self)weakself = self;
    [[MineServiceApi share]getMenberInfoWithParam:req response:^(id response) {
        if (response) {
            weakself.result = response;
            [UserCacheBean share].userInfo.memberId = weakself.result.memberId;
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

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
#import "MemberShipController.h"
#import "PromoteQrController.h"
#import "MineMedalController.h"
#import "MineIntegralController.h"
#import "AddMemberPayController.h"
#import "MemberShipController.h"


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
        _footView = [[MineFootView alloc]initWithFrame:CGRectMake(0, 290, SCREENWIDTH, 400)];
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
    if ([UserCacheBean share].userInfo.token.length>0) {
        MessageController *messageVC = [[MessageController alloc]init];
        messageVC.hidesBottomBarWhenPushed = YES;
        [weakself.navigationController pushViewController:messageVC animated:YES];
    }else{
        LoginController *loginVC = [[LoginController alloc]init];
        loginVC.hidesBottomBarWhenPushed = YES;
        [weakself.navigationController pushViewController:loginVC animated:YES];
    }
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
        if ([UserCacheBean share].userInfo.token.length>0) {
           if (index ==0) {
               LoginController *loginVC = [[LoginController alloc]init];
               loginVC.hidesBottomBarWhenPushed = YES;
               [weakself.navigationController pushViewController:loginVC animated:YES];
           }else if (index ==1) {
                HistoryBaseController *setVC = [[HistoryBaseController alloc]init];
                setVC.hidesBottomBarWhenPushed = YES;
                [weakself.navigationController pushViewController:setVC animated:YES];
            }else if (index ==2){
                DownLoadController *setVC = [[DownLoadController alloc]init];
                setVC.hidesBottomBarWhenPushed = YES;
                [weakself.navigationController pushViewController:setVC animated:YES];
            }
        }else{
            LoginController *loginVC = [[LoginController alloc]init];
            loginVC.hidesBottomBarWhenPushed = YES;
            [weakself.navigationController pushViewController:loginVC animated:YES];
        }
        
    }];
    [self.headView setAddBlock:^{
     if ([UserCacheBean share].userInfo.token.length>0) {
        MemberShipController*memberVC = [[MemberShipController alloc]init];
        memberVC.hidesBottomBarWhenPushed = YES;
        [weakself.navigationController pushViewController:memberVC animated:YES];
     }else{
         LoginController *loginVC = [[LoginController alloc]init];
         loginVC.hidesBottomBarWhenPushed = YES;
         [weakself.navigationController pushViewController:loginVC animated:YES];
     }
         
    }];
    
    [self.footView setSelecteBlock:^(NSUInteger index) {
        if ([UserCacheBean share].userInfo.token.length>0) {
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
                    MineIntegralController *setVC = [[MineIntegralController alloc]init];
                    setVC.hidesBottomBarWhenPushed = YES;
                    [weakself.navigationController pushViewController:setVC animated:YES];
                }
                    break;
                case 2:
                {
                    MineMedalController *setVC = [[MineMedalController alloc]init];
                    setVC.hidesBottomBarWhenPushed = YES;
                    [weakself.navigationController pushViewController:setVC animated:YES];
                }
                    break;
                case 3:
                {
                    CollectionBaseController *setVC = [[CollectionBaseController alloc]init];
                    setVC.hidesBottomBarWhenPushed = YES;
                    [weakself.navigationController pushViewController:setVC animated:YES];
                }
                    break;
                case 4:
                {
                    MineFollowController *setVC = [[MineFollowController alloc]init];
                    setVC.hidesBottomBarWhenPushed = YES;
                    [weakself.navigationController pushViewController:setVC animated:YES];
                }
                    break;
                case 5:
                {
                    SettingController *setVC = [[SettingController alloc]init];
                    setVC.hidesBottomBarWhenPushed = YES;
                    [weakself.navigationController pushViewController:setVC animated:YES];
                }
                    break;
                case 6:
                {
                    EnterShhController *enterVC = [[EnterShhController alloc]init];
                    enterVC.hidesBottomBarWhenPushed = YES;
                    [weakself.navigationController pushViewController:enterVC animated:YES];
                }
                    break;
                case 7:
                {
                    HelpCenterController *helpVC = [[HelpCenterController alloc]init];
                    helpVC.hidesBottomBarWhenPushed = YES;
                    [weakself.navigationController pushViewController:helpVC animated:YES];
                }
                    break;
                case 100:
                {
                        if (self.result.studyStatus ==0) {
                            AddMemberPayController *addVC = [[AddMemberPayController alloc]init];
                            addVC.hidesBottomBarWhenPushed = YES;
                            [addVC setType:1];
                            [weakself.navigationController pushViewController:addVC animated:YES];
                        }else if (self.result.studyStatus ==1){
                            MemberShipController *addVC = [[MemberShipController alloc]init];
                            addVC.hidesBottomBarWhenPushed = YES;
                            [addVC setType:1];
                            [weakself.navigationController pushViewController:addVC animated:YES];
                        }else if (self.result.studyStatus ==2){
                            MemberShipController *addVC = [[MemberShipController alloc]init];
                            addVC.hidesBottomBarWhenPushed = YES;
                            [addVC setType:1];
                            [weakself.navigationController pushViewController:addVC animated:YES];
                        }
                    
                }
                    break;
                case 101:
                {
                    if (self.result.presidentStatus ==0) {
                        AddMemberPayController *addVC = [[AddMemberPayController alloc]init];
                        addVC.hidesBottomBarWhenPushed = YES;
                        [addVC setType:2];
                        [weakself.navigationController pushViewController:addVC animated:YES];
                    }else if (self.result.presidentStatus ==1){
                        MemberShipController *addVC = [[MemberShipController alloc]init];
                        addVC.hidesBottomBarWhenPushed = YES;
                        [addVC setType:2];
                        [weakself.navigationController pushViewController:addVC animated:YES];
                    }else if (self.result.presidentStatus ==2){
                        MemberShipController *addVC = [[MemberShipController alloc]init];
                        addVC.hidesBottomBarWhenPushed = YES;
                        [addVC setType:2];
                        [weakself.navigationController pushViewController:addVC animated:YES];
                    }
                }
                    break;
                default:
                    break;
            }
        }else{
            LoginController *loginVC = [[LoginController alloc]init];
            loginVC.hidesBottomBarWhenPushed = YES;
            [weakself.navigationController pushViewController:loginVC animated:YES];
        }
        
    }];
    [self.footView setTapBlock:^{
        if ([UserCacheBean share].userInfo.token.length>0) {
          PromoteQrController *qrVC = [[PromoteQrController alloc]init];
          qrVC.hidesBottomBarWhenPushed = YES;
          [weakself.navigationController pushViewController:qrVC animated:YES];
        }else{
            LoginController *loginVC = [[LoginController alloc]init];
            loginVC.hidesBottomBarWhenPushed = YES;
            [weakself.navigationController pushViewController:loginVC animated:YES];
        }
    }];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    if ([UserCacheBean share].userInfo.token.length>0) {
       
        [self requestData];
    }else{
        self.headView.frame = CGRectMake(0, 0, SCREENWIDTH, 290);
        [self.headView.editBtn setTitle:@"未登录" forState:UIControlStateNormal];
        self.headView.headImage.image = [UIImage imageNamed:@"mine"];
        [self.headView setModel:nil];
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
            [weakself.headView setModel:weakself.result];
            [UserCacheBean share].userInfo.memberId = weakself.result.memberId;
            [UserCacheBean share].userInfo.memberAvatarPath = weakself.result.memberAvatarPath;
            [UserCacheBean share].userInfo.memberName = weakself.result.memberName;
            [UserCacheBean share].userInfo.memberMobile = weakself.result.memberTel;
            [weakself.headView.editBtn setTitle:[UserCacheBean share].userInfo.memberName forState:UIControlStateNormal];
            [weakself.headView.editBtn setImage:[UIImage imageNamed:@"edit_mine"] forState:UIControlStateNormal];
            if (weakself.result.memberName.length>0) {
                [weakself.headView.editBtn setIconInRightWithSpacing:7];
            }else{
                
            }
           
            [weakself.headView.headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",DPHOST,weakself.result.memberAvatarPath]] placeholderImage:[UIImage imageNamed:@"mine"]];
            
            
                    if (weakself.result.studyStatus == 1) {
                        [weakself.footView.yanright setTitle:@"信息有待完善" forState:UIControlStateNormal];
                        [weakself.footView.yanright setIconInRightWithSpacing:10];
                    }else if (weakself.result.studyStatus == 2){
                        [weakself.footView.yanright setTitle:@"        已加入" forState:UIControlStateNormal];
                        [weakself.footView.yanright setIconInRightWithSpacing:10];
                    }else if (weakself.result.studyStatus == 0){
                        [weakself.footView.yanright setTitle:@"" forState:UIControlStateNormal];
                        [weakself.footView.yanright setIconInRightWithSpacing:80];
                    }
                    
            
                    if (weakself.result.presidentStatus ==1) {
                        [weakself.footView.zongright setTitle:@"信息有待完善" forState:UIControlStateNormal];
                        [weakself.footView.zongright setIconInRightWithSpacing:10];
                    }else if (weakself.result.presidentStatus ==2){
                        [weakself.footView.zongright setTitle:@"        已加入" forState:UIControlStateNormal];
                        [weakself.footView.zongright setIconInRightWithSpacing:10];
                    }else if (weakself.result.presidentStatus ==0){
                        [weakself.footView.zongright setTitle:@"" forState:UIControlStateNormal];
                        [weakself.footView.zongright setIconInRightWithSpacing:80];
                    }
              
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end


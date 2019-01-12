//
//  DetailCourseController.m
//  Shh
//
//  Created by dnaer7 on 2018/11/6.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "DetailCourseController.h"
#import "HomeServiceApi.h"
#import "VedioHeadView.h"
#import "ZSNotification.h"
#import "CommentCell.h"
#import "CommentHeadCell.h"
#import "LoginController.h"
#import "DetailAudioController.h"
#import "InputToolbar.h"
#import "UIView+Extension.h"
#import "PayViewController.h"
#import "UIViewController+SJVideoPlayerAdd.h"
#import "SuspensionAudioView.h"
#import "HgMusicPlayerManager.h"
#import "AudioPlayController.h"

@interface DetailCourseController ()<SJRouteHandler,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *courseArr;
@property(nonatomic,strong)NSMutableArray *commentArr;
@property(nonatomic,strong)DetailCourseRes *detailCourse;
@property(nonatomic,strong)VedioHeadView *headsView;
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,assign)CGFloat headHeight;
@property(nonatomic,strong)UILabel *footView;
@property (nonatomic,strong)InputToolbar *inputToolbar;
@property (nonatomic,assign)CGFloat inputToolbarY;
@property(nonatomic,strong)CommentReq *commentReq;
@property(nonatomic,strong)SingleCourseDrectoryRes*detailModel;
@property (nonatomic, strong) SJVideoPlayer *player;
@property(nonatomic,strong)SuspensionAudioView *susView;
@property (nonatomic,strong)NSTimer *timer;
@property(nonatomic,assign)NSInteger second;

@end

@implementation DetailCourseController
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStyleGrouped];
        _tableview.delegate = self;
        _tableview.dataSource = self;
//        _tableview.backgroundColor = [UIColor whiteColor];
        _tableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 60)];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableview;
}
-(SuspensionAudioView *)susView{
    if (!_susView) {
        _susView = [[SuspensionAudioView alloc]initWithFrame:CGRectMake(30, SCREENHEIGHT-[self tabBarHeight]-85-[self navHeightWithHeight], SCREENWIDTH-60, 80)];
        [_susView.layer setCornerRadius:4];
        [_susView.layer setMasksToBounds:YES];
        _susView.hidden = YES;
        _susView.backgroundColor = [UIColor whiteColor];
        [_susView.layer setBorderColor:DSColorFromHex(0x969696).CGColor];
        [_susView.layer setBorderWidth:0.5];
        
    }
    return _susView;
}
-(UILabel *)footView{
    if (!_footView) {
        _footView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 140)];
        _footView.text = @"暂无评论！赶紧抢个沙发！";
        _footView.backgroundColor = [UIColor whiteColor];
        _footView.textAlignment = NSTextAlignmentCenter;
        _footView.textColor = DSColorFromHex(0x464646);
        _footView.font = [UIFont systemFontOfSize:14];
    }
    return _footView;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.inputToolbar.isBecomeFirstResponder = NO;
    self.inputToolbar.keyboardIsVisiable = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.tableview.contentInsetAdjustmentBehavior = NO;
    } else {
        self.navigationController.navigationBar.translucent = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.tableview];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.sj_displayMode = SJPreViewDisplayMode_Origin;
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    __weak typeof(self) _self = self;
    [self.headsView setVideoBlock:^(CourseListModel * model) {
        [_self.player pause];
        _self.player.URLAsset = [[SJVideoPlayerURLAsset alloc] initWithURL:[NSURL URLWithString:model.courseMediaPath] playModel:[SJPlayModel UITableViewHeaderViewPlayModelWithPlayerSuperview:_self.headsView.view.coverImageView tableView:_self.tableview]];
    }];
    self.headsView.view.clickedPlayButtonExeBlock = ^(SJPlayView * _Nonnull view) {
        __strong typeof(_self) self = _self;
        if ( !self ) return ;
        if (self.detailCourse.memberIsBuyThisCourse ==YES) {
        [self.player stopAndFadeOut];
        self.player = [SJVideoPlayer player];
#ifdef SJMAC
        self.player.disablePromptWhenNetworkStatusChanges = YES;
#endif
        [view.coverImageView addSubview:self.player.view];
        [self.player.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.headsView.view);
            make.height.mas_equalTo(200*SCREENWIDTH/375);
        }];
            if (self.detailModel.courseMediaPath.length>0) {
                self.player.URLAsset = [[SJVideoPlayerURLAsset alloc] initWithURL:[NSURL URLWithString:self.detailModel.courseMediaPath] playModel:[SJPlayModel UITableViewHeaderViewPlayModelWithPlayerSuperview:self.headsView.view.coverImageView tableView:self.tableview]];
            }
        
        self.player.URLAsset.title = @"";
        self.player.URLAsset.alwaysShowTitle = NO;
        }else{
            if ([UserCacheBean share].userInfo.token.length>0) {
                [self showInfo:@"请先购买"];
                PayViewController *payVC = [[PayViewController alloc]init];
                [payVC setCourseId:self.detailCourse.course.courseId];
                [self.navigationController pushViewController:payVC animated:YES];
            }else{
                LoginController *loginVC = [[LoginController alloc]init];
                loginVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:loginVC animated:YES];
            }
        }
    };
    
    self.tableview.tableHeaderView = self.headsView;
    self.courseArr = [NSMutableArray array];
    self.commentArr = [NSMutableArray array];
    self.commentReq = [[CommentReq alloc]init];
    self.commentReq.beCommentId = @"";
    self.commentReq.beCommentMemberId = @"";
    self.commentReq.beCommentMemberNickname = @"";
     self.tableview.tableFooterView = self.footView;
    [self.view addSubview:self.susView];
    
    __weak typeof(self)weakself = self;
    [self.headsView setHeightBlock:^(CGFloat height) {
        weakself.headHeight = height;
        weakself.headsView.frame = CGRectMake(0, 0, SCREENWIDTH, height);
        [weakself.tableview reloadData];
    }];
    [self.headsView setAudioBlock:^(BOOL selected, CourseListModel * model) {
        if (self.detailCourse.memberIsBuyThisCourse ==YES  ) {
            weakself.susView.hidden = NO;
            [weakself.susView setModel:model];
            [weakself.player pause];
        }else{
            if ([UserCacheBean share].userInfo.token.length>0) {
                [weakself showInfo:@"请先购买"];
                PayViewController *payVC = [[PayViewController alloc]init];
                [payVC setCourseId:weakself.detailCourse.course.courseId];
                [weakself.navigationController pushViewController:payVC animated:YES];
            }else{
                LoginController *loginVC = [[LoginController alloc]init];
                loginVC.hidesBottomBarWhenPushed = YES;
                [weakself.navigationController pushViewController:loginVC animated:YES];
            }
        }
    }];
    [self.susView setPlayBlock:^(BOOL selected) {
        if (selected ==NO) {
            weakself.susView.playBtn.selected = YES;
            [[HgMusicPlayerManager shared]play:weakself.susView.model.courseMediaPath];
            [weakself.timer setFireDate:[NSDate distantPast]]; //很远的过去
        }else{
            weakself.susView.playBtn.selected = NO;
            [[HgMusicPlayerManager shared]stopPlay];
            [weakself.timer setFireDate:[NSDate distantFuture]];  //很远的将来
            
        }
    }];
    [self.susView setDetailBlock:^{
        weakself.susView.playBtn.selected = NO;
        [[HgMusicPlayerManager shared]stopPlay];
        AudioPlayController*audioVC = [[AudioPlayController alloc]init];
        [audioVC setAudioRes:weakself.susView.model];
        [weakself.navigationController pushViewController:audioVC animated:YES];
    }];

    [self.headsView setFouceBlock:^(BOOL selected) {
        if ([UserCacheBean share].userInfo.token.length>0) {
            
            [weakself getFollow];
        }else{
            LoginController *loginVC = [[LoginController alloc]init];
            loginVC.hidesBottomBarWhenPushed = YES;
            [weakself.navigationController pushViewController:loginVC animated:YES];
        }
    }];
    [self.headsView setListBlock:^(FreeListRes * model) {
        if ([model.courseVideoOrAudio isEqualToString:@"audio"]) {
            DetailAudioController *detailVC = [[DetailAudioController alloc]init];
            [detailVC setModel:model];
            [weakself.player stop];
            [weakself.navigationController pushViewController:detailVC animated:YES];
        }else if ([model.courseVideoOrAudio isEqualToString:@"video"]){
            DetailCourseController *detailVC = [[DetailCourseController alloc]init];
            [detailVC setModel:model];
            [weakself.player stop];
            [weakself.navigationController pushViewController:detailVC animated:YES];
        }
        
    }];
    
    self.inputToolbar = [InputToolbar shareInstance];
    [self.view addSubview:self.inputToolbar];
    self.inputToolbar.textViewMaxVisibleLine = 4;
    self.inputToolbar.width = self.view.width;
    self.inputToolbar.height = [self navHeightWithHeight];
    [self.inputToolbar setType:@"1"];
//    self.inputToolbar.y = SCREENHEIGHT-[self navHeightWithHeight]*2;
    self.inputToolbar.frame = CGRectMake(0, SCREENHEIGHT-[self navHeightWithHeight]*2, SCREENWIDTH, [self navHeightWithHeight]);
    [self.inputToolbar setMorebuttonViewDelegate:self];
 
    self.inputToolbar.sendContent = ^(NSObject *content){
        weakself.inputToolbar.isBecomeFirstResponder = NO;
        weakself.inputToolbar.y = SCREENHEIGHT-[self navHeightWithHeight]*2;
        weakself.susView.frame =  CGRectMake(30, SCREENHEIGHT-[self tabBarHeight]-85, SCREENWIDTH-60, 80);
        if ([UserCacheBean share].userInfo.token.length>0) {
            [weakself addComment:(NSString*)content];
        }else{
            LoginController *loginVC = [[LoginController alloc]init];
            loginVC.hidesBottomBarWhenPushed = YES;
            [weakself.navigationController pushViewController:loginVC animated:YES];
        }
    };
    
    self.inputToolbar.inputToolbarFrameChange = ^(CGFloat height,CGFloat orignY){
       
        weakself.inputToolbarY = orignY;
        weakself.susView.frame =  CGRectMake(30, orignY-90, SCREENWIDTH-60, 80);
        if (weakself.tableview.contentSize.height > orignY) {
            [weakself.tableview setContentOffset:CGPointMake(0, weakself.tableview.contentSize.height - orignY) animated:YES];
        }
        
    };
    [self.inputToolbar setZanBlock:^(BOOL selected) {
        if ([UserCacheBean share].userInfo.token.length>0) {
            [weakself getLike:@"course" CourseId:weakself.detailCourse.course.courseId];
        }else{
            LoginController *loginVC = [[LoginController alloc]init];
            loginVC.hidesBottomBarWhenPushed = YES;
            [weakself.navigationController pushViewController:loginVC animated:YES];
        }
    }];
    [self.inputToolbar setXinBlock:^(BOOL selected) {
        if ([UserCacheBean share].userInfo.token.length>0) {
            [weakself getCollect];
        }else{
            LoginController *loginVC = [[LoginController alloc]init];
            loginVC.hidesBottomBarWhenPushed = YES;
            [weakself.navigationController pushViewController:loginVC animated:YES];
        }
    }];
    
    [self.inputToolbar resetInputToolbar];
    
}
- (void)dealloc {
    NSLog(@"dealloc");
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.inputToolbar.isBecomeFirstResponder = NO;
}


- (void)inputToolbar:(InputToolbar *)inputToolbar orignY:(CGFloat)orignY
{
    _inputToolbarY = orignY;
}
-(void)addComment:(NSString*)content{
    
    self.commentReq.appId = @"1041622992853962754";
    self.commentReq.token = [UserCacheBean share].userInfo.token;
    self.commentReq.timestamp = @"0";
    self.commentReq.platform = @"ios";
    self.commentReq.commentContent = content;
    self.commentReq.commentType = @"comment";
     CourseListModel *model = [self.detailCourse.courseList firstObject];
    self.commentReq.articleOrCourseId = model.courseId;
    __weak typeof(self)weakself = self;
    [[HomeServiceApi share]addCommentWithParam:self.commentReq response:^(id response) {
        if ([response[@"code"] integerValue] ==200) {
            [weakself showInfo:@"评论成功"];
            [weakself getCommentList];
            weakself.commentReq.beCommentMemberNickname = @"";
            weakself.commentReq.beCommentMemberId = @"";
            weakself.commentReq.beCommentId = @"";
        }else{
            [weakself showInfo:response[@"message"]];
        }
    }];
}

-(VedioHeadView *)headsView{
    if (!_headsView) {
        _headsView = [[VedioHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, _headHeight)];
        
    }
    return _headsView;
}
-(void)setModel:(FreeListRes *)model{
    _model = model;
    self.title = @"课程详情";
    [self getCourseList];
}
-(void)getFollow{
    FollowReq *req = [[FollowReq alloc]init];
    req.appId = @"1041622992853962754";
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.platform = @"ios";
    req.version = @"1.0.0";
    req.cityName = @"上海市";
    if (self.detailCourse.member.memberId.length>0) {
        req.beFollowId = self.detailCourse.member.memberId;
        req.type = @"member";
    }else{
        req.beFollowId = self.detailCourse.course.courseId;
        req.type = @"course";
    }
   
    __weak typeof(self)weakself = self;
    [[HomeServiceApi share]followWithParam:req response:^(id response) {
        if (response) {
            [weakself showInfo:response[@"message"]];
            if ([response[@"code"]integerValue] ==200  ) {
                if (weakself.headsView.fouceBtn.selected ==NO) {
                    weakself.headsView.fouceBtn.backgroundColor = DSColorFromHex(0xF0F0F0);
                    weakself.headsView.fouceBtn.selected = YES;
                }else{
                    weakself.headsView.fouceBtn.backgroundColor = DSColorFromHex(0xE70019);
                    weakself.headsView.fouceBtn.selected = NO;
                }
            }
        }
    }];
}
-(void)getLike:(NSString*)type CourseId:(NSString*)Id{
    FreeListReq *req = [[FreeListReq alloc]init];
    req.appId = @"1041622992853962754";
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.platform = @"ios";
    req.articleOrCourseId= Id;
    req.articleOrCourseType = type;
    __weak typeof(self)weakself = self;
    [[HomeServiceApi share]likeWithParam:req response:^(id response) {
        if (response) {
            [weakself showInfo:response[@"message"]];
            if ([type isEqualToString:@"comment"]) {
                [weakself getCommentList];
            }else{
                if ([response[@"code"]integerValue] ==200  ) {
                    if (weakself.inputToolbar.emojiButton.selected ==NO) {
                        weakself.inputToolbar.emojiButton.selected = YES;
                    }else{
                        weakself.inputToolbar.emojiButton.selected = NO;
                    }
                }
            }
        }
    }];
}
-(void)getCollect{
    FreeListReq *req = [[FreeListReq alloc]init];
    req.appId = @"1041622992853962754";
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.platform = @"ios";
    req.articleOrCourseId= self.detailCourse.course.courseId;
    req.articleOrCourseType = @"course";
    req.articleOrCourseTitle = self.detailCourse.course.courseTitle;
    req.articleOrCourseImagePath = self.detailCourse.course.courseAppImagePath;
    __weak typeof(self)weakself = self;
    [[HomeServiceApi share]bookWithParam:req response:^(id response) {
        if (response) {
            [weakself showInfo:response[@"message"]];
            if ([response[@"code"]integerValue] ==200  ) {
                if (weakself.inputToolbar.moreButton.selected ==NO) {
                    weakself.inputToolbar.moreButton.selected = YES;
                }else{
                    weakself.inputToolbar.moreButton.selected = NO;
                }
            }
        }
    }];
}
-(void)getSingleCourse{
    FreeListReq *req = [[FreeListReq alloc]init];
    req.appId = @"1041622992853962754";
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.platform = @"ios";
    req.courseId = _model.courseId;
    req.courseCategoryId = @"";
    req.pageIndex = 1;
    req.pageSize = @"10";
    __weak typeof(self)weakself = self;
    [[HomeServiceApi share]getsingleWithParam:req response:^(id response) {
        if ([response isKindOfClass:[DetailCourseRes class]]) {
            weakself.detailCourse = [[DetailCourseRes alloc]init];
            weakself.detailCourse = response;
            if (weakself.detailCourse.courseList.count>0) {
                CourseListModel *model = [weakself.detailCourse.courseList firstObject];
                [weakself.headsView setDetailCourse:weakself.detailCourse];
                [weakself getSingleFind:model.courseListId];
            }
            [weakself.susView setDetailCourse:weakself.detailCourse];
            weakself.inputToolbar.emojiButton.selected = weakself.detailCourse.memberIsLike;
            weakself.inputToolbar.moreButton.selected = weakself.detailCourse.memberIsBook;
        }else{
            [weakself showInfo:response[@"message"]];
        }
        
    }];
}

-(void)getCourseList{
    FreeListReq *req = [[FreeListReq alloc]init];
    req.appId = @"1041622992853962754";
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.platform = @"ios";
    req.columnId = @"";
    req.courseCategoryId = _model.courseCategoryId;
    req.pageIndex = 1;
    req.pageSize = @"5";
    __weak typeof(self)weakself = self;
    [[HomeServiceApi share]getFineClassWithParam:req response:^(id response) {
        if ([response isKindOfClass:[NSArray class]]) {
            [weakself.courseArr removeAllObjects];
            [weakself.courseArr addObjectsFromArray:response];
            for (FreeListRes * model in response) {
                if ([model.courseId isEqualToString:weakself.model.courseId]) {
                    [weakself.courseArr removeObject:model];
                }
            }
            [weakself.headsView setDataArr:weakself.courseArr];
        }else{
            [weakself showInfo:response[@"message"]];
        }
        [weakself getCommentList];
    }];
    
}
-(void)getCommentList{
    FreeListReq *req = [[FreeListReq alloc]init];
    req.appId = @"1041622992853962754";
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.platform = @"ios";
    req.articleOrCourseId = _model.courseId;
    req.courseCategoryId = @"";
    req.pageIndex = 1;
    req.pageSize = @"10";
    __weak typeof(self)weakself = self;
    [[HomeServiceApi share]getCommentListWithParam:req response:^(id response) {
        if (response) {
            [weakself.commentArr removeAllObjects];
            [weakself.commentArr addObjectsFromArray:response];
            
            if (weakself.commentArr.count ==0) {
                weakself.footView.text = @"暂无评论！赶紧抢个沙发！";
            }else{
                weakself.footView.text = @"";
            }
            [weakself.tableview reloadData];
        }
        [weakself getSingleCourse];
    }];
}
-(void)getSingleFind:(NSString*)courseListId{
    FreeListReq *req = [[FreeListReq alloc]init];
    req.appId = @"1041622992853962754";
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.platform = @"ios";
    req.courseListId = courseListId;
    req.courseCategoryId = @"";
    req.pageIndex = 1;
    req.pageSize = @"10";
    self.detailModel = [[SingleCourseDrectoryRes alloc]init];
    __weak typeof(self)weakself = self;
    [[HomeServiceApi share]SingleCourseDirectoryWithParam:req response:^(id response) {
        if ([response isKindOfClass:[SingleCourseDrectoryRes class]]) {

            [weakself.headsView setModel:response];
            self.detailModel = response;
            if (self.detailModel.courseMediaPath.length>0) {
                self.player.URLAsset = [[SJVideoPlayerURLAsset alloc] initWithURL:[NSURL URLWithString:self.detailModel.courseMediaPath] playModel:[SJPlayModel UITableViewHeaderViewPlayModelWithPlayerSuperview:self.headsView tableView:self.tableview]];
            }else{
                self.headsView.playButton.hidden = YES;
            }
            
        }else{
            [self showInfo:response[@"message"]];
        }
            
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.commentArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    CommentListRes *model = self.commentArr[section];
    return model.beCommentList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CommentListRes *model = self.commentArr[section];
    return [CommentHeadCell getCellHeight:model];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentListRes *model = self.commentArr[indexPath.section];
    BeCommentModel *becommentmodel = model.beCommentList[indexPath.row];
    return [CommentCell getCellHeight:becommentmodel];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CommentHeadCell *headView = [[CommentHeadCell alloc]init];
    CommentListRes *model = self.commentArr[section];
    headView.frame = CGRectMake(0, 0, 0, [CommentHeadCell getCellHeight:model]);
    
    if (section ==0) {
        headView.lineLabel.hidden = YES;
    }else{
        headView.lineLabel.hidden = NO;
    }
    [headView setModel:model];
    headView.backgroundColor = [UIColor whiteColor];
//    __weak typeof(headView)wealhead = headView;
    __weak typeof(self)wealself = self;
    [headView setZanBlock:^(BOOL selected) {
        if ([UserCacheBean share].userInfo.token.length>0) {

            [wealself getLike:@"comment" CourseId:model.commentId];
        }else{
            LoginController *loginVC = [[LoginController alloc]init];
            loginVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:loginVC animated:YES];
        }
    }];
    [headView setCommentBlock:^(CommentListRes *model1) {
        if ([UserCacheBean share].userInfo.token.length>0) {
            wealself.inputToolbar.isBecomeFirstResponder = YES;
            wealself.commentReq.beCommentId = model.commentId;
            wealself.commentReq.beCommentMemberId = model.memberId;
            wealself.commentReq.beCommentMemberNickname = model.memberNickname;
        
        }else{
            LoginController *loginVC = [[LoginController alloc]init];
            loginVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:loginVC animated:YES];
        }
    }];
    return headView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"CommentCell";
    
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    CommentListRes *model = self.commentArr[indexPath.section];
    BeCommentModel *becommentmodel = model.beCommentList[indexPath.row];
    [cell setModel:becommentmodel];
    __weak typeof(self)weakself = self;
    [cell setSelectedBlock:^(BeCommentModel * model) {
        weakself.inputToolbar.isBecomeFirstResponder = YES;
        weakself.commentReq.beCommentId = model.beCommentId;
        weakself.commentReq.beCommentMemberId = model.beCommentMemberId;
        weakself.commentReq.beCommentMemberNickname = model.beCommentMemberNickname;
        weakself.commentReq.commentType = @"comment";
        weakself.commentReq.articleOrCourseId = weakself.detailCourse.course.courseId;
    }];
    return cell;
}



- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.player vc_viewDidAppear];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.player vc_viewWillDisappear];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.player vc_viewDidDisappear];
}

- (BOOL)prefersStatusBarHidden {
    return [self.player vc_prefersStatusBarHidden];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.player vc_preferredStatusBarStyle];
}

- (BOOL)prefersHomeIndicatorAutoHidden {
    return YES;
}
-(void)updateTime{
    self.second +=1;
    NSInteger minute = self.second/60;
    NSInteger ss = self.second%60;
    self.susView.dateLabel.text = [NSString stringWithFormat:@"%.2ld:%.2ld",minute,ss];
}
@end

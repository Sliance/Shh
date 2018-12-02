//
//  DetailAudioController.m
//  Shh
//
//  Created by dnaer7 on 2018/11/8.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "DetailAudioController.h"
#import "HomeServiceApi.h"
#import "AudioHeadView.h"
#import "ZSNotification.h"
#import "CommentCell.h"
#import "CommentHeadCell.h"
#import "LoginController.h"
#import "InputToolbar.h"
#import "UIView+Extension.h"
#import "HgMusicPlayerManager.h"

@interface DetailAudioController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *courseArr;
@property(nonatomic,strong)NSMutableArray *commentArr;
@property(nonatomic,strong)DetailCourseRes *detailCourse;
@property(nonatomic,strong)AudioHeadView *headView;
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,assign)CGFloat headHeight;
@property(nonatomic,strong)UILabel *footView;
@property (nonatomic,strong)InputToolbar *inputToolbar;
@property (nonatomic,assign)CGFloat inputToolbarY;
@property(nonatomic,strong)CommentReq *commentReq;
@property(nonatomic,strong)SingleCourseDrectoryRes *audioRes;

@end

@implementation DetailAudioController
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
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    self.tableview.tableHeaderView = self.headView;
    self.courseArr = [NSMutableArray array];
    self.commentArr = [NSMutableArray array];
    self.commentReq = [[CommentReq alloc]init];
    self.commentReq.beCommentId = @"";
    self.commentReq.beCommentMemberId = @"";
    self.commentReq.beCommentMemberNickname = @"";
    self.tableview.tableFooterView = self.footView;
    __weak typeof(self)weakself = self;
    [self.headView setHeightBlock:^(CGFloat height) {
        weakself.headHeight = height;
        weakself.headView.frame = CGRectMake(0, 0, SCREENWIDTH, height);
        [weakself.tableview reloadData];
    }];
    [self.headView setPlayBlock:^(BOOL selected) {
        if (self.detailCourse.memberIsBuyThisCourse ==YES  ) {
            if (selected ==NO) {
                 [[HgMusicPlayerManager shared]play:weakself.audioRes.courseMediaPath];
                weakself.headView.selected = YES;
            }else{
                [[HgMusicPlayerManager shared]stopPlay];
                weakself.headView.selected = NO;
                
            }
           
        }else{
            [weakself showInfo:@"请先购买"];
        }
    }];
    [self.headView setFouceBlock:^(BOOL selected) {
        if ([UserCacheBean share].userInfo.token.length>0) {
            if (selected ==NO) {
                weakself.headView.fouceBtn.backgroundColor = DSColorFromHex(0xDCDCDC);
            }else{
                weakself.headView.fouceBtn.backgroundColor = DSColorFromHex(0xE70019);
            }
        }else{
            LoginController *loginVC = [[LoginController alloc]init];
            loginVC.hidesBottomBarWhenPushed = YES;
            [weakself.navigationController pushViewController:loginVC animated:YES];
        }
    }];
    [self.headView setListBlock:^(FreeListRes * model) {
        DetailAudioController *detailVC = [[DetailAudioController alloc]init];
        [detailVC setModel:model];
        [weakself.navigationController pushViewController:detailVC animated:YES];
    }];
    self.inputToolbar = [InputToolbar shareInstance];
    [self.view addSubview:self.inputToolbar];
    self.inputToolbar.textViewMaxVisibleLine = 4;
    self.inputToolbar.width = self.view.width;
    self.inputToolbar.height = [self navHeightWithHeight];
    self.inputToolbar.y = SCREENHEIGHT - [self navHeightWithHeight];
    [self.inputToolbar setMorebuttonViewDelegate:self];
    
    self.inputToolbar.sendContent = ^(NSObject *content){
        
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
        if (weakself.tableview.contentSize.height > orignY) {
            [weakself.tableview setContentOffset:CGPointMake(0, weakself.tableview.contentSize.height - orignY) animated:YES];
        }
    };
    [self.inputToolbar setZanBlock:^(BOOL selected) {
        if ([UserCacheBean share].userInfo.token.length>0) {
            if (selected ==NO) {
                weakself.inputToolbar.emojiButton.selected = YES;
            }else{
                weakself.inputToolbar.emojiButton.selected = NO;
            }
        }else{
            LoginController *loginVC = [[LoginController alloc]init];
            loginVC.hidesBottomBarWhenPushed = YES;
            [weakself.navigationController pushViewController:loginVC animated:YES];
        }
    }];
    [self.inputToolbar setXinBlock:^(BOOL selected) {
        if ([UserCacheBean share].userInfo.token.length>0) {
            if (selected ==NO) {
                weakself.inputToolbar.moreButton.selected = YES;
            }else{
                weakself.inputToolbar.moreButton.selected = NO;
            }
        }else{
            LoginController *loginVC = [[LoginController alloc]init];
            loginVC.hidesBottomBarWhenPushed = YES;
            [weakself.navigationController pushViewController:loginVC animated:YES];
        }
    }];
    
    [self.inputToolbar resetInputToolbar];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressTap)];
    [self.tableview addGestureRecognizer:tap];
    
}
-(void)pressTap{
    [self.view endEditing:YES];
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
-(AudioHeadView *)headView{
    if (!_headView) {
        _headView = [[AudioHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        
    }
    return _headView;
}
-(void)setModel:(FreeListRes *)model{
    _model = model;
    self.title = @"课程详情";
    [self getCourseList];
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
        if (response) {
            weakself.detailCourse = [[DetailCourseRes alloc]init];
            weakself.detailCourse = response;
            CourseListModel *model = [weakself.detailCourse.courseList firstObject];
            [weakself.headView setDetailCourse:weakself.detailCourse];
            [weakself getSingleFind:model.courseListId];
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
        if (response) {
            [weakself.courseArr removeAllObjects];
            [weakself.courseArr addObjectsFromArray:response];
            for (FreeListRes * model in response) {
                if ([model.courseId isEqualToString:weakself.model.courseId]) {
                    [weakself.courseArr removeObject:model];
                }
            }
            [weakself.headView setDataArr:weakself.courseArr];
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
    __weak typeof(self)weakself = self;
    self.audioRes = [[SingleCourseDrectoryRes alloc]init];
    [[HomeServiceApi share]SingleCourseDirectoryWithParam:req response:^(id response) {
        if (response) {
            weakself.audioRes = response;

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
    __weak typeof(headView)wealself = headView;
    
    [headView setZanBlock:^(BOOL selected) {
        if ([UserCacheBean share].userInfo.token.length>0) {
            wealself.zanBtn.selected = !selected;
            if (selected ==NO) {
                
            }else{
                
            }
        }else{
            LoginController *loginVC = [[LoginController alloc]init];
            loginVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:loginVC animated:YES];
        }
    }];
    [headView setCommentBlock:^(CommentListRes * model) {
        if ([UserCacheBean share].userInfo.token.length>0) {
            
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
    return cell;
}


@end

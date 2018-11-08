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

@interface DetailCourseController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *courseArr;
@property(nonatomic,strong)NSMutableArray *commentArr;
@property(nonatomic,strong)DetailCourseRes *detailCourse;
@property(nonatomic,strong)VedioHeadView *headView;
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,assign)CGFloat headHeight;

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
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    self.tableview.tableHeaderView = self.headView;
    self.courseArr = [NSMutableArray array];
    self.commentArr = [NSMutableArray array];
    __weak typeof(self)weakself = self;
    [self.headView setHeightBlock:^(CGFloat height) {
        weakself.headHeight = height;
        weakself.headView.frame = CGRectMake(0, 0, SCREENWIDTH, height);
        [weakself.tableview reloadData];
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
    [ZSNotification addChangeDirectionResultNotification:self action:@selector(changeDirection:)];
}
-(void)changeDirection:(NSNotification *)noti{
    NSDictionary *userInfo = [noti userInfo];
    if ([[userInfo objectForKey:@"direction"] isEqualToString:@"landscrap"]) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        self.headView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
        self.tableview.tableHeaderView = nil;
        [self.view addSubview:self.headView];
    }else if ([[userInfo objectForKey:@"direction"] isEqualToString:@"ver"]){
        if (self.headHeight>0) {
            
            self.headView.frame = CGRectMake(0, 0, SCREENWIDTH, self.headHeight);
        }else{
            self.headView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
        }
        for (UIView *view in self.view.subviews) {
            if ([view isKindOfClass:[VedioHeadView class]]) {
                [view removeFromSuperview];
            }
        }
        self.tableview.tableHeaderView = self.headView;
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        
    }
}
-(VedioHeadView *)headView{
    if (!_headView) {
        _headView = [[VedioHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        
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
    req.pageSize = @"10";
    __weak typeof(self)weakself = self;
    [[HomeServiceApi share]getFineClassWithParam:req response:^(id response) {
        if (response) {
            [weakself.courseArr removeAllObjects];
            [weakself.courseArr addObjectsFromArray:response];
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
    [[HomeServiceApi share]SingleCourseDirectoryWithParam:req response:^(id response) {
        if (response) {

            [weakself.headView setModel:response];
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

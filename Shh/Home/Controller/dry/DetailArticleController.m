//
//  DetailArticleController.m
//  Shh
//
//  Created by dnaer7 on 2018/11/6.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "DetailArticleController.h"
#import "HomeServiceApi.h"
#import "VedioHeadView.h"
#import "ZSNotification.h"
#import "CommentCell.h"
#import "CommentHeadCell.h"
#import "LoginController.h"
#import "ArticleHeadView.h"

@interface DetailArticleController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *articleArr;
@property(nonatomic,strong)NSMutableArray *commentArr;
@property(nonatomic,strong)DetailArticleRes *detailCourse;
@property(nonatomic,strong)ArticleHeadView *headView;
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,assign)CGFloat headHeight;

@end

@implementation DetailArticleController
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStyleGrouped];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 60)];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableview;
}
-(ArticleHeadView *)headView{
    if (!_headView) {
        _headView = [[ArticleHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        
    }
    return _headView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    self.tableview.tableHeaderView = self.headView;
    self.articleArr = [NSMutableArray array];
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
    [self.headView setListBlock:^(TodayListRes * model) {
        DetailArticleController *detailVC = [[DetailArticleController alloc]init];
        [detailVC setModel:model];
        [weakself.navigationController pushViewController:detailVC animated:YES];
    }];
}
-(void)getArticleList:(NSString*)colmunid{
    FreeListReq *req = [[FreeListReq alloc]init];
    req.appId = @"1041622992853962754";
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.platform = @"ios";
    req.columnId = colmunid;
    req.courseCategoryId = @"";
    req.pageIndex = 1;
    req.pageSize = @"5";
    __weak typeof(self)weakself = self;
    [[HomeServiceApi share]getTodayListWithParam:req response:^(id response) {
        if (response) {
            [weakself.articleArr removeAllObjects];
            [weakself.articleArr addObjectsFromArray:response];
            [weakself.headView setDataArr:weakself.articleArr];
            [weakself.tableview reloadData];
        }
        
    }];
}
-(void)getSingleArticle{
    FreeListReq *req = [[FreeListReq alloc]init];
    req.appId = @"1041622992853962754";
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.platform = @"ios";
    req.articleId = _model.articleId;
    req.courseCategoryId = @"";
    req.pageIndex = 1;
    req.pageSize = @"10";
    __weak typeof(self)weakself = self;
    [[HomeServiceApi share]getSingleArticleWithParam:req response:^(id response) {
        if (response) {
            weakself.detailCourse = [[DetailArticleRes alloc]init];
            weakself.detailCourse = response;
            
            [weakself.headView setModel:weakself.detailCourse];
        }
         [weakself getArticleList:weakself.model.columnId];
        
    }];
}
-(void)getCommentList{
    FreeListReq *req = [[FreeListReq alloc]init];
    req.appId = @"1041622992853962754";
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.platform = @"ios";
    req.articleOrCourseId = _model.articleId;
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
        [weakself getSingleArticle];
       
    }];
}
-(void)setModel:(TodayListRes *)model{
    _model = model;
    self.title = @"文章详情";
    [self getCommentList];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

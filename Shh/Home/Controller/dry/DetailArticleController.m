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
#import "InputToolbar.h"
#import "UIView+Extension.h"
@interface DetailArticleController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *articleArr;
@property(nonatomic,strong)NSMutableArray *commentArr;
@property(nonatomic,strong)DetailArticleRes *detailCourse;
@property(nonatomic,strong)ArticleHeadView *headView;
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,assign)CGFloat headHeight;
@property(nonatomic,strong)UILabel *footView;
@property (nonatomic,strong)InputToolbar *inputToolbar;
@property (nonatomic,assign)CGFloat inputToolbarY;
@property(nonatomic,strong)CommentReq *commentReq;
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
    [self.headView setFouceBlock:^(BOOL selected) {
        if ([UserCacheBean share].userInfo.token.length>0) {
            
            [weakself getFollow];
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
    self.inputToolbar = [InputToolbar shareInstance];
    [self.view addSubview:self.inputToolbar];
    self.inputToolbar.textViewMaxVisibleLine = 4;
    self.inputToolbar.width = self.view.width;
    self.inputToolbar.height = [self navHeightWithHeight];
    self.inputToolbar.y = SCREENHEIGHT - [self navHeightWithHeight];
    [self.inputToolbar setMorebuttonViewDelegate:self];
    
    self.inputToolbar.sendContent = ^(NSObject *content){
        weakself.inputToolbar.isBecomeFirstResponder = NO;
        weakself.inputToolbarY = [weakself navHeightWithHeight];
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
            [weakself getLike:@"article" CourseId:weakself.detailCourse.articleId];
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
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressTap)];
//    [self.tableview addGestureRecognizer:tap];
    
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
-(void)getFollow{
    FollowReq *req = [[FollowReq alloc]init];
    req.appId = @"1041622992853962754";
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.platform = @"ios";
    req.version = @"1.0.0";
    req.cityName = @"上海市";
    req.beFollowMemberId = self.detailCourse.member.memberId;
    __weak typeof(self)weakself = self;
    [[HomeServiceApi share]followWithParam:req response:^(id response) {
        if (response) {
            [weakself showInfo:response[@"message"]];
            if ([response[@"code"]integerValue] ==200  ) {
            if (weakself.headView.fouceBtn.selected ==NO) {
                weakself.headView.fouceBtn.backgroundColor = DSColorFromHex(0xF0F0F0);
                weakself.headView.fouceBtn.selected = YES;
            }else{
                weakself.headView.fouceBtn.backgroundColor = DSColorFromHex(0xE70019);
                weakself.headView.fouceBtn.selected = NO;
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
    req.articleOrCourseId= self.detailCourse.articleId;
    req.articleOrCourseType = @"article";
    req.articleOrCourseTitle = self.detailCourse.articleTitle;
    req.articleOrCourseImagePath = self.detailCourse.articleAppCoverImagePath;
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
-(void)addComment:(NSString*)content{
    
    self.commentReq.appId = @"1041622992853962754";
    self.commentReq.token = [UserCacheBean share].userInfo.token;
    self.commentReq.timestamp = @"0";
    self.commentReq.platform = @"ios";
    self.commentReq.commentContent = content;
    self.commentReq.commentType = @"comment";
    self.commentReq.articleOrCourseId = self.detailCourse.articleId;
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
            for (TodayListRes * model in response) {
                if ([model.articleId isEqualToString:weakself.model.articleId]) {
                    [weakself.articleArr removeObject:model];
                }
            }
            [weakself.headView setDataArr:weakself.articleArr];
            [weakself.tableview reloadData];
        }
        [weakself getSingleArticle];
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
            weakself.inputToolbar.emojiButton.selected = weakself.detailCourse.memberIsLike;
            weakself.inputToolbar.moreButton.selected = weakself.detailCourse.memberIsBook;
            [weakself.headView setModel:weakself.detailCourse];
        }
        
        
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
            if (weakself.commentArr.count ==0) {
                weakself.footView.text = @"暂无评论！赶紧抢个沙发！";
            }else{
                weakself.footView.text = @"";
            }
            [weakself.tableview reloadData];
        }
        [weakself getArticleList:weakself.model.columnId];
       
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
    __weak typeof(self)weakself = self;
    [headView setZanBlock:^(BOOL selected) {
        if ([UserCacheBean share].userInfo.token.length>0) {
            
            [weakself getLike:@"comment" CourseId:model.commentId];
        }else{
            LoginController *loginVC = [[LoginController alloc]init];
            loginVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:loginVC animated:YES];
        }
    }];
    [headView setCommentBlock:^(CommentListRes *model1) {
       weakself.inputToolbar.isBecomeFirstResponder = YES;
        weakself.commentReq.beCommentId = model1.beCommentId;
        weakself.commentReq.beCommentMemberId = model1.beCommentMemberId;
        weakself.commentReq.beCommentMemberNickname = model1.beCommentMemberNickname;
        
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
        weakself.commentReq.articleOrCourseId = weakself.detailCourse.articleId;
    }];
    
    
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

//
//  AudioHeadView.m
//  Shh
//
//  Created by dnaer7 on 2018/11/7.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "AudioHeadView.h"
#import "HomeLikeCell.h"
#import "AudioCell.h"

@implementation AudioHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.headImage];
        [self addSubview:self.nameLabel];
        [self addSubview:self.detailLabel];
        [self addSubview:self.lineLabel];
        [self addSubview:self.fouceBtn];
        
        [self addSubview:self.introductLabel];
        [self addSubview:self.recommendLabel];
        [self addSubview:self.introducTDecs];
        [self addSubview:self.collectionView];
        [self addSubview:self.lineLabel1];
        [self addSubview:self.commentLabel];
        [self addSubview:self.commentBtn];
        [self addSubview:self.bannerImage];
        [self addSubview:self.contentLabel];
        [self addSubview:self.tableview];
        [self setLayoutVer];
        
    }
    return self;
}
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.scrollEnabled = NO;
    }
    return _tableview;
}
-(UIImageView *)bannerImage{
    if (!_bannerImage) {
        _bannerImage = [[UIImageView alloc]init];
    }
    return _bannerImage;
}
-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        [_headImage.layer setCornerRadius:25];
        [_headImage.layer setMasksToBounds:YES];
        
    }
    return _headImage;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = DSColorFromHex(0x464646);
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}
-(UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.textColor = DSColorFromHex(0x787878);
        _detailLabel.font = [UIFont systemFontOfSize:14];
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        _detailLabel.numberOfLines = 2;
    }
    return _detailLabel;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor = DSColorFromHex(0x474747);
        _contentLabel.font = [UIFont boldSystemFontOfSize:18];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.text = @"课程内容";
    }
    return _contentLabel;
}
-(UILabel *)introductLabel{
    if (!_introductLabel) {
        _introductLabel = [[UILabel alloc]init];
        _introductLabel.textColor = DSColorFromHex(0x474747);
        _introductLabel.font = [UIFont boldSystemFontOfSize:18];
        _introductLabel.textAlignment = NSTextAlignmentLeft;
        _introductLabel.text = @"课程简介";
    }
    return _introductLabel;
}
-(UILabel *)introducTDecs{
    if (!_introducTDecs) {
        _introducTDecs = [[UILabel alloc]init];
        _introducTDecs.textColor = DSColorFromHex(0x474747);
        _introducTDecs.font = [UIFont systemFontOfSize:14];
        _introducTDecs.textAlignment = NSTextAlignmentLeft;
        _introducTDecs.numberOfLines =0;
    }
    return _introducTDecs;
}
-(UILabel *)recommendLabel{
    if (!_recommendLabel) {
        _recommendLabel = [[UILabel alloc]init];
        _recommendLabel.textColor = DSColorFromHex(0x474747);
        _recommendLabel.font = [UIFont boldSystemFontOfSize:18];
        _recommendLabel.textAlignment = NSTextAlignmentLeft;
        _recommendLabel.text = @"相关推荐";
    }
    return _recommendLabel;
}
-(UILabel *)commentLabel{
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc]init];
        _commentLabel.textColor = DSColorFromHex(0x474747);
        _commentLabel.font = [UIFont boldSystemFontOfSize:18];
        _commentLabel.textAlignment = NSTextAlignmentLeft;
        _commentLabel.text = @"评论";
    }
    return _commentLabel;
}
-(UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = DSColorFromHex(0xE6E6E6);
    }
    return _lineLabel;
}
-(UILabel *)lineLabel1{
    if (!_lineLabel1) {
        _lineLabel1 = [[UILabel alloc]init];
        _lineLabel1.backgroundColor = DSColorFromHex(0xE6E6E6);
    }
    return _lineLabel1;
}
-(UIButton *)fouceBtn{
    if (!_fouceBtn) {
        _fouceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _fouceBtn.backgroundColor = DSColorFromHex(0xE70019);
        [_fouceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_fouceBtn setTitle:@"关注" forState:UIControlStateNormal];
        [_fouceBtn setTitleColor:DSColorFromHex(0x969696) forState:UIControlStateSelected];
        [_fouceBtn setTitle:@"已关注" forState:UIControlStateSelected];
      
        _fouceBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [_fouceBtn.layer setCornerRadius:3];
        [_fouceBtn addTarget:self action:@selector(pressFouce:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fouceBtn;
}
-(UIButton *)commentBtn{
    if (!_commentBtn) {
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentBtn setTitleColor:DSColorFromHex(0xE70019) forState:UIControlStateNormal];
        [_commentBtn setTitle:@"写评论" forState:UIControlStateNormal];
        _commentBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [_commentBtn.layer setCornerRadius:3];
    }
    return _commentBtn;
}

-(void)setDetailCourse:(DetailCourseRes *)detailCourse{
    _detailCourse = detailCourse;
    [self.tableview reloadData];
    NSString *url = [NSString stringWithFormat:@"%@%@",DPHOST,detailCourse.member.memberAvatarPath];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:url]];
    NSString *bannerurl = [NSString stringWithFormat:@"%@%@",DPHOST,detailCourse.course.courseAppImagePath];
    [self.bannerImage sd_setImageWithURL:[NSURL URLWithString:bannerurl]];
    if (detailCourse.haveFollowMember ==YES) {
        self.fouceBtn.selected = YES;
        self.fouceBtn.backgroundColor = DSColorFromHex(0xF0F0F0);
    }else{
        self.fouceBtn.selected = NO;
        self.fouceBtn.backgroundColor = DSColorFromHex(0xE70019);
    }
    self.nameLabel.text = detailCourse.member.memberName;
    self.detailLabel.text = detailCourse.member.memberDesc;
    
    self.tableview.frame = CGRectMake(0, self.contentLabel.ctBottom+15, SCREENWIDTH, detailCourse.courseList.count*60);
    self.introductLabel.frame = CGRectMake(14, self.tableview.ctBottom+17, SCREENWIDTH-30, 17);
    [self.introducTDecs setText:detailCourse.course.courseIntroduction lineSpacing:5];
    self.introducTDecs.frame = CGRectMake(15, self.introductLabel.ctBottom+20, SCREENWIDTH-30, [self.introducTDecs getHeightLineWithString:detailCourse.course.courseIntroduction withWidth:SCREENWIDTH-30 withFont:[UIFont systemFontOfSize:14]lineSpacing:5]);
   
    self.recommendLabel.frame = CGRectMake(14, self.introducTDecs.ctBottom+37, SCREENWIDTH-30, 17);
    self.collectionView.frame = CGRectMake(0, self.recommendLabel.ctBottom+20, SCREENWIDTH, 140);
    self.lineLabel1.frame = CGRectMake(0, self.collectionView.ctBottom+1, SCREENWIDTH, 1);
    self.commentLabel.frame = CGRectMake(15, self.lineLabel1.ctBottom+17, SCREENWIDTH, 17);
    self.commentBtn.frame = CGRectMake(SCREENWIDTH-60, self.lineLabel1.ctBottom+10, 50, 36);
    
    self.heightBlock(self.commentBtn.ctBottom);
   
}
-(void)setLayoutVer{
    self.bannerImage.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENWIDTH * 9 / 16);
    self.headImage.frame = CGRectMake(15, SCREENWIDTH * 9 / 16+15, 50, 50);
    self.nameLabel.frame = CGRectMake(self.headImage.ctRight+10, self.headImage.ctTop, SCREENWIDTH-120, 16);
    self.detailLabel.frame = CGRectMake(self.headImage.ctRight+10, self.nameLabel.ctBottom+5, SCREENWIDTH-120, 40);
    self.lineLabel.frame = CGRectMake(0, self.detailLabel.ctBottom+15, SCREENWIDTH, 1);
    
    self.fouceBtn.frame = CGRectMake(SCREENWIDTH-55, self.headImage.ctTop, 40, 20);
    self.contentLabel.frame = CGRectMake(14, self.lineLabel.ctBottom+17, SCREENWIDTH-30, 17);
    
}
-(void)setLayoutLand{
    self.headImage.frame = CGRectMake(15, SCREENWIDTH +65, 50, 50);
    self.nameLabel.frame = CGRectMake(self.headImage.ctRight+10, self.headImage.ctTop, SCREENWIDTH-120, 16);
    self.detailLabel.frame = CGRectMake(self.headImage.ctRight+10, self.nameLabel.ctBottom+5, SCREENWIDTH-120, 40);
    self.lineLabel.frame = CGRectMake(0, self.detailLabel.ctBottom+15, SCREENWIDTH, 1);
    
    self.fouceBtn.frame = CGRectMake(SCREENWIDTH-55, self.headImage.ctTop, 40, 20);
    self.contentLabel.frame = CGRectMake(14, self.lineLabel.ctBottom+17, SCREENWIDTH-30, 17);
}
-(void)changeDirection:(NSNotification *)noti{
    NSDictionary *userInfo = [noti userInfo];
    if ([[userInfo objectForKey:@"direction"] isEqualToString:@"landscrap"]) {
        [self setLayoutLand];
    }else if ([[userInfo objectForKey:@"direction"] isEqualToString:@"ver"]){
        [self setLayoutVer];
    }
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 2;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, 140) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[HomeLikeCell class] forCellWithReuseIdentifier:@"HomeLikeCell"];
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
        [_collectionView
         registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footreusableView"];
    }
    return _collectionView;
}
-(void)setDataArr:(NSMutableArray *)dataArr{
    _dataArr = dataArr;
    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
    
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(135, 140);
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeLikeCell *collectcell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeLikeCell" forIndexPath:indexPath];
    [collectcell setImageWidth:125];
    [collectcell setImageHeight:71];
    collectcell.nameLabel.numberOfLines = 2;
    FreeListRes *model = self.dataArr[indexPath.row];
    [collectcell setFreeModel:model];
    return collectcell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
     FreeListRes *model = self.dataArr[indexPath.row];
    self.listBlock(model);
}
-(void)pressFouce:(UIButton*)sender{
    
    
    self.fouceBlock(sender.selected);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.detailCourse.courseList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"AudioCell";
    AudioCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[AudioCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    CourseListModel*model = self.detailCourse.courseList[indexPath.row];
    model.memberIsBuyThisCourse = self.detailCourse.memberIsBuyThisCourse;
    model.watch = self.detailCourse.watchCount;
    [cell setModel:model];
   
    __weak typeof(self)weakself = self;
    [cell setPlayBlock:^(BOOL selected) {
        weakself.playBlock(selected);
    }];
    cell.playBtn.selected = self.selected;
    return cell;
}
-(void)setSelected:(BOOL)selected{
    _selected = selected;
    [self.tableview reloadData];
}
@end

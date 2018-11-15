//
//  ArticleHeadView.m
//  Shh
//
//  Created by dnaer7 on 2018/11/8.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "ArticleHeadView.h"
static NSString *nowcellIds = @"HomeNowCell";
@implementation ArticleHeadView

-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        [_headImage.layer setCornerRadius:15];
        [_headImage.layer setMasksToBounds:YES];
        
    }
    return _headImage;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = DSColorFromHex(0x474747);
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}
-(UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.textColor = DSColorFromHex(0x787878);
        _detailLabel.font = [UIFont systemFontOfSize:12];
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        _detailLabel.numberOfLines = 2;
    }
    return _detailLabel;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = DSColorFromHex(0x474747);
        _titleLabel.font = [UIFont boldSystemFontOfSize:21];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}
-(UILabel *)fouceLabel{
    if (!_fouceLabel) {
        _fouceLabel = [[UILabel alloc]init];
        _fouceLabel.textColor = DSColorFromHex(0xB5B5B5);
        _fouceLabel.font = [UIFont systemFontOfSize:12];
        _fouceLabel.textAlignment = NSTextAlignmentRight;
        _fouceLabel.numberOfLines = 2;
    }
    return _fouceLabel;
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
-(UIWebView *)webView{
    if(!_webView){
        _webView = [[UIWebView alloc]init];
        _webView.delegate = self;
        _webView.scrollView.scrollEnabled = NO;
    }
    return _webView;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(15,SCREENHEIGHT, SCREENWIDTH-30, SCREENHEIGHT) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[HomeNowCell class] forCellWithReuseIdentifier:nowcellIds];
        
        _collectionView.backgroundColor = DSColorFromHex(0xFAFAFA);
        _collectionView.scrollEnabled = NO;
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
        [_collectionView
         registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footreusableView"];
    }
    return _collectionView;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    self.webView.frame = CGRectMake(0, self.headImage.ctBottom+20, SCREENWIDTH, self.webView.scrollView.contentSize.height);
    self.recommendLabel.frame = CGRectMake(15, self.webView.ctBottom, SCREENWIDTH-30, 18);
    
    self.collectionView.frame = CGRectMake(0, self.recommendLabel.ctBottom+10, SCREENWIDTH, 115*self.
                                           dataArr.count);
    self.lineLabel.frame = CGRectMake(0, self.collectionView.ctBottom+20, SCREENWIDTH, 1);
    self.commentLabel.frame =  CGRectMake(15, self.collectionView.ctBottom+35, SCREENWIDTH-30, 18);
    
    self.heightBlock(self.commentLabel.ctBottom);
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.headImage];
        [self addSubview:self.titleLabel];
        [self addSubview:self.nameLabel];
        [self addSubview:self.detailLabel];
        [self addSubview:self.fouceBtn];
        [self addSubview:self.fouceLabel];
        [self addSubview:self.webView];
        [self addSubview:self.recommendLabel];
        [self addSubview:self.commentLabel];
        [self addSubview:self.lineLabel];
        [self addSubview:self.collectionView];
        self.titleLabel.frame = CGRectMake(15, 5, SCREENWIDTH-30, 60);
        self.headImage.frame = CGRectMake(15, self.titleLabel.ctBottom+20, 30, 30);
        self.nameLabel.frame = CGRectMake(self.headImage.ctRight+10, self.headImage.ctTop, SCREENWIDTH/2, 14);
        self.detailLabel.frame = CGRectMake(self.headImage.ctRight+10, self.nameLabel.ctBottom+2, SCREENWIDTH/2, 14);
        self.fouceBtn.frame = CGRectMake(SCREENWIDTH-55, self.headImage.ctTop+5, 40, 20);
        self.fouceLabel.frame = CGRectMake(SCREENWIDTH-155, self.headImage.ctTop, 90, 30);
        self.webView.frame = CGRectMake(0, self.headImage.ctBottom+20, SCREENWIDTH, 100);
    }
    return self;
}
-(void)setModel:(DetailArticleRes *)model{
    _model = model;
    self.titleLabel.text = model.articleTitle;
    NSString *url = [NSString stringWithFormat:@"%@%@",DPHOST,model.member.memberAvatarPath];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:url]];
    self.nameLabel.text = model.member.memberName;
    self.detailLabel.text = model.member.memberDesc;
    self.fouceLabel.text = [NSString stringWithFormat:@"%@人已关注",model.beFollowCount];
    NSString *html_str = [NSString stringWithFormat:@"<head><style>img{width:%fpx !important;}</style></head>%@",SCREENWIDTH-15,model.articleText];
    
    [self.webView loadHTMLString:html_str baseURL:nil];
}
-(void)setDataArr:(NSMutableArray *)dataArr{
    _dataArr = dataArr;
   
    [self.collectionView reloadData];
}
-(void)pressFouce:(UIButton*)sender{
    
    
    self.fouceBlock(sender.selected);
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


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 5;
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(SCREENWIDTH, 115);
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    
    
    return CGSizeMake(SCREENWIDTH, 0);
    
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeNowCell *nowcell = [collectionView dequeueReusableCellWithReuseIdentifier:nowcellIds forIndexPath:indexPath];
    TodayListRes *model = self.dataArr[indexPath.row];
    [nowcell setModel:model];
    return nowcell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TodayListRes *model = self.dataArr[indexPath.row];
    self.listBlock(model);
}
@end

//
//  PromoteServiceView.m
//  Shh
//
//  Created by 燕来秋mac9 on 2018/8/31.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "PromoteServiceView.h"
#import "QualityCollectionCell.h"

@implementation PromoteServiceView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setCortentLayout];
        self.backgroundColor = DSColorFromHex(0xF5F5F5);
    }
    return self;
}
-(void)setCortentLayout{
    
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.rightLabel];
    
    [self.bgView addSubview:self.allBtn];
    [self.bgView addSubview:self.collectionView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self).offset(7);
        make.height.mas_equalTo(293);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(15);
        make.top.equalTo(self.bgView);
        make.height.mas_equalTo(50);
    }];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-15);
        make.centerY.equalTo(self.titleLabel);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(12);
    }];
    [self.allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightLabel.mas_left);
        make.top.equalTo(self.bgView);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(50);
    }];
    
}
-(UIView *)bgView{
    if(!_bgView){
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.textColor = DSColorFromHex(0x474747);
        _titleLabel.text = @"推介服务";
    }
    return _titleLabel;
}
- (UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.font = [UIFont fontWithName:@"icomoon"size:12];
        _rightLabel.text = @"\U0000e90d";
        _rightLabel.textColor = DSColorFromHex(0x787878);
    }
    return _rightLabel;
}

-(UIButton *)allBtn{
    if (!_allBtn) {
        _allBtn.backgroundColor = [UIColor redColor];
        _allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allBtn setTitle:@"全部" forState:UIControlStateNormal];
        [_allBtn setTitleColor:DSColorFromHex(0x787878) forState:UIControlStateNormal];
        _allBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_allBtn addTarget:self action:@selector(pressAll:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allBtn;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 2;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 60, SCREENWIDTH, 235) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[QualityCollectionCell class] forCellWithReuseIdentifier:@"QualityCollectionCell"];
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
        [_collectionView
         registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footreusableView"];
        _collectionView.contentOffset = CGPointMake(10+350-(SCREENWIDTH-350)/2, 0);
        _collectionView.decelerationRate = UIScrollViewDecelerationRateNormal;
        _collectionView.bounces = NO;
        
    }
    return _collectionView;
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
    
    return CGSizeMake(SCREENWIDTH-30, 235);
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    QualityCollectionCell *collectcell = [collectionView dequeueReusableCellWithReuseIdentifier:@"QualityCollectionCell" forIndexPath:indexPath];
    [collectcell setImageWidth:340];
    [collectcell setImageHeight:175];
    ServiceListRes *model = self.dataArr[indexPath.row];
    [collectcell setRecomendModel:model];
    return collectcell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedBlock(indexPath.row);
}
-(void)setDataArr:(NSMutableArray *)dataArr{
    _dataArr = dataArr;
    [self.collectionView reloadData];
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    self.offer = scrollView.contentOffset.x;
    
    NSLog(@"end========%f",self.offer);
    
}


- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.x < (self.dataArr.count-1)
        *SCREENWIDTH) {
        
        if (scrollView.contentOffset.x > self.offer) {
            
            int i = scrollView.contentOffset.x/([UIScreen mainScreen].bounds.size.width - 60)+1;
            
            NSIndexPath * index =  [NSIndexPath indexPathForRow:i inSection:0];
            
            [_collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
            
        }else{
            
            int i = scrollView.contentOffset.x/([UIScreen mainScreen].bounds.size.width - 60)+1;
            
            NSIndexPath * index =  [NSIndexPath indexPathForRow:i-1 inSection:0];
            
            [_collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
            
        }
        
    }
    
}





//用户拖拽是调用

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    NSLog(@"###%f",scrollView.contentOffset.x);
    if (scrollView.contentOffset.x < (self.dataArr.count-1)
             *SCREENWIDTH) {
        
        if (scrollView.contentOffset.x < self.offer) {
            
            int i = scrollView.contentOffset.x/([UIScreen mainScreen].bounds.size.width - 30)+1;
            
            NSIndexPath * index =  [NSIndexPath indexPathForRow:i inSection:0];
            
            [_collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
            
        }else{
            
            int i = scrollView.contentOffset.x/([UIScreen mainScreen].bounds.size.width - 30)+1;
            
            NSIndexPath * index =  [NSIndexPath indexPathForRow:i-1 inSection:0];
            
            [_collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
            
        }
        
    }
    
}

-(void)pressAll:(UIButton*)sender{
    self.allBlock();
}
@end

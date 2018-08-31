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

@interface MineController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *bgscrollow;
@property(nonatomic,strong)MineHeadView *headView;
@property(nonatomic,strong)MineFootView *footView;


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
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

//
//  CourseController.m
//  Shh
//
//  Created by 燕来秋mac9 on 2018/8/23.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "CourseController.h"
#import "MenuInfo.h"

#import "BaseCourseController.h"
#import "NavigationView.h"
@interface CourseController ()
@property (nonatomic, strong)  NSMutableArray *menuList;
@property (nonatomic, assign)  BOOL autoSwitch;
@property (nonatomic, strong)NavigationView *navView;
@end

@implementation CourseController
-(NavigationView *)navView{
    if (!_navView) {
        _navView = [[NavigationView alloc]init];
        _navView.frame = CGRectMake(0, 0, SCREENWIDTH, [self navHeightWithHeight]);
    }
    return _navView;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.view.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _menuList = [NSMutableArray array];
    self.magicView.itemScale = 1;
    self.magicView.headerHeight = 40;
    self.magicView.navigationHeight = [self navHeightWithHeight]+120;
    self.magicView.againstStatusBar = YES;
    self.magicView.navigationInset = UIEdgeInsetsMake(120+[self navHeightWithHeight]-40, 0, 0, 0);
    self.magicView.headerView.backgroundColor = [UIColor whiteColor];
    self.magicView.navigationColor = [UIColor whiteColor];
    self.magicView.layoutStyle = VTLayoutStyleDefault;
    self.magicView.sliderColor = DSColorFromHex(0xE70019);
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    [self integrateComponents];
    [self configSeparatorView];
    
    [self addNotification];
    
    [self.magicView reloadData];
    [self generateTestData];
    [self.magicView reloadMenuTitles];
    [self.magicView reloadDataToPage:0];
   
    [self.view addSubview:self.navView];
}
-(void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    [self.magicView reloadDataToPage:selectedIndex];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (_autoSwitch) {
        [self.magicView switchToPage:0 animated:YES];
        _autoSwitch = NO;
    }
}
#pragma mark - NSNotification
- (void)addNotification {
    [self removeNotification];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(statusBarOrientationChange:)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification
                                               object:nil];
}

- (void)removeNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (void)statusBarOrientationChange:(NSNotification *)notification {
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:YES];
}

#pragma mark - VTMagicViewDataSource
- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView {
    NSMutableArray *titleList = [NSMutableArray array];
    for (MenuInfo *menu in _menuList) {
        [titleList addObject:menu.title];
    }
    return titleList;
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex {
    static NSString *itemIdentifier = @"itemIdentifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuItem setTitleColor:RGBCOLOR(69, 69, 69) forState:UIControlStateNormal];
        [menuItem setTitleColor:DSColorFromHex(0xE70019) forState:UIControlStateSelected];
        menuItem.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15.f];
    }
//     默认会自动完成赋值
        MenuInfo *menuInfo = _menuList[itemIndex];
        [menuItem setTitle:menuInfo.title forState:UIControlStateNormal];
    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex {
    
    static NSString *gridId = @"identifier";
    BaseCourseController *viewController = [magicView dequeueReusablePageWithIdentifier:gridId];
    if (!viewController) {
        viewController = [[BaseCourseController alloc] init];
        
    }
    viewController.selectedIndex = pageIndex;
    return viewController;
}

#pragma mark - VTMagicViewDelegate
- (void)magicView:(VTMagicView *)magicView viewDidAppear:(__kindof UIViewController *)viewController atPage:(NSUInteger)pageIndex {
    _selectedIndex = pageIndex;
    
    [viewController setSelectedIndex:pageIndex];
//    [viewController setModel:model];
}

- (void)magicView:(VTMagicView *)magicView viewDidDisappear:(__kindof UIViewController *)viewController atPage:(NSUInteger)pageIndex {
    //    NSLog(@"index:%ld viewDidDisappear:%@", (long)pageIndex, viewController.view);
}

- (void)magicView:(VTMagicView *)magicView didSelectItemAtIndex:(NSUInteger)itemIndex {
    //    NSLog(@"didSelectItemAtIndex:%ld", (long)itemIndex);
}

#pragma mark - actions
- (void)subscribeAction {
    
    
}

#pragma mark - functional methods
- (void)generateTestData {
    NSString *title = @"推荐";
    NSMutableArray *menuList = [[NSMutableArray alloc] initWithCapacity:24];
    [menuList addObject:[MenuInfo menuInfoWithTitl:title]];
    [menuList removeAllObjects];
    NSArray *_dataArr = @[@"分类",@"微课堂",@"会员大课",@"大咖分享",@"倍增学院"];
    for (int index = 0; index < _dataArr.count; index++) {
        NSString *str = _dataArr[index];
        MenuInfo *menu = [MenuInfo menuInfoWithTitl:str];
        [menuList addObject:menu];
    }
    _menuList = menuList;
}

- (void)integrateComponents {
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH-50, [self navHeightWithHeight]+40, 50, 40)];
    [rightButton addTarget:self action:@selector(subscribeAction) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setImage:[UIImage imageNamed:@"down_icon"] forState:UIControlStateNormal];
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, -10, 0);
    
    UIButton *btn =  [[UIButton alloc] initWithFrame:CGRectMake(0,0, 50, 40)];
//    self.magicView.rightNavigatoinItem = btn;
//    [self.magicView.navigationView addSubview:rightButton];
    
}

- (void)configSeparatorView {
    //    UIImageView *separatorView = [[UIImageView alloc] init];
    //    [self.magicView setSeparatorView:separatorView];
    self.magicView.separatorHeight = 2.f;
    self.magicView.separatorColor = DSColorFromHex(0xE70019);
    self.magicView.navigationView.layer.shadowColor = [UIColor whiteColor].CGColor;
    self.magicView.navigationView.layer.shadowOffset = CGSizeMake(0, 0.5);
    self.magicView.navigationView.layer.shadowOpacity = 0.8;
    self.magicView.navigationView.clipsToBounds = NO;
    
    
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

//
//  MineHeadView.h
//  Shh
//
//  Created by 燕来秋mac9 on 2018/8/29.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "MemberInfoRes.h"
@interface MineHeadView : BaseView
@property(nonatomic,strong)UIImageView *bgImage;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UIView *hYView;
@property(nonatomic,strong)UILabel *hYimage;
@property(nonatomic,strong)UILabel *hYtitle;
@property(nonatomic,strong)UILabel *hYDate;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UIButton *editBtn;
@property(nonatomic,strong)UIButton *messageBtn;
@property(nonatomic,strong)UIButton *serviceBtn;
@property(nonatomic,strong)NSMutableArray *btnArr;
@property(nonatomic,strong)UIButton *openBtn;
@property(nonatomic,strong)UIButton *memberBtn;
@property(nonatomic,strong)UIButton *studyBtn;
@property(nonatomic,strong)UIButton *presidentBtn;

@property(nonatomic,copy)void (^messageBlock)(void);
@property(nonatomic,copy)void (^editBlock)(void);
@property(nonatomic,copy)void (^typeBlock)(NSInteger);
@property(nonatomic,copy)void (^addBlock)(void);
@property(nonatomic,strong)MemberInfoRes *model;

@end

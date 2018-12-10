//
//  SuspensionAudioView.h
//  Shh
//
//  Created by zhangshu on 2018/12/10.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "DetailCourseRes.h"
NS_ASSUME_NONNULL_BEGIN

@interface SuspensionAudioView : BaseView
@property (nonatomic, strong) UIImageView *bannerImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) UIButton *nameBtn;
@property(nonatomic,strong)DetailCourseRes *detailCourse;
@property(nonatomic,copy)void (^playBlock)(BOOL);
@property(nonatomic,copy)void (^detailBlock)(void);

@end

NS_ASSUME_NONNULL_END

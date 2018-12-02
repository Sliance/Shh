//
//  YGPlayerView.h
//  Demo
//
//  Created by LiYugang on 2018/3/5.
//  Copyright © 2018年 LiYugang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@class YGPlayInfo;

@interface YGPlayerView : UIView
@property (nonatomic, strong) NSNumber *leftConstraint;
@property (nonatomic, strong) NSNumber *topConstraint;
@property (nonatomic, strong) NSNumber *widthConstraint;
@property (nonatomic, strong) NSNumber *heightConstraint;
@property (nonatomic, strong) AVPlayer *player;
- (void)playWithPlayInfo:(YGPlayInfo *)playInfo;
- (BOOL)isPlaying;

@property(nonatomic,copy)void (^playBlock)(void);


@end

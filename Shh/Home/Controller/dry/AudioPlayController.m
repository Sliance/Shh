//
//  AudioPlayController.m
//  Shh
//
//  Created by zhangshu on 2018/12/10.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "AudioPlayController.h"
#import "HgSongInfo.h"
#import "NSObject+Hg.h"

@interface AudioPlayController ()
@property (nonatomic,strong)NSTimer *timer;
@property(nonatomic,assign)NSInteger second;
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)UILabel *titleLabel;

@end

@implementation AudioPlayController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"正在播放 1/1";
        self.view.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 320+[self navHeightWithHeight], SCREENWIDTH, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = DSColorFromHex(0x464646);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
-(UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc]init];
        _headView.backgroundColor = DSColorFromHex(0xF0F0F0);
        [_headView.layer setCornerRadius:4];
        [_headView.layer setMasksToBounds:YES];
        [_headView.layer setBorderColor:DSColorFromHex(0xDCDCDC).CGColor];
        [_headView.layer setBorderWidth:2];
        _headView.frame = CGRectMake(SCREENWIDTH/2-100, 80+[self navHeightWithHeight], 200, 200);
    }
    return _headView;
}
-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self playStateRecover];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[HgMusicPlayerManager shared]stopPlay];
    [self.timer invalidate];
    self.timer = nil;
}
-(void)setAudioRes:(CourseListModel *)audioRes{
    _audioRes = audioRes;
    [[HgMusicPlayerManager shared] play:audioRes.courseAudioPath];
    CMTime duration = HgMusicPlayerManager.shared.play.currentItem.asset.duration;
    // 歌曲总时间和当前时间
    NSInteger completeTime = CMTimeGetSeconds(duration);
    NSInteger minute = completeTime/60;
    NSInteger ss = completeTime%60;
    _bottomView.songSlider.maximumValue = completeTime;
    _bottomView.durationTimeLabel.text = [NSString stringWithFormat:@"%.2ld:%.2ld",minute,ss];
    _titleLabel.text = audioRes.courseTitle;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // bottom view 初始化
    [self.view addSubview:self.headView];
    [self.view addSubview:self.titleLabel];
    _bottomView = [[HgMusicBottomView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-300, SCREENWIDTH, self.view.frame.size.height / 5)];
    [self.view addSubview:_bottomView];
    
    // 添加playOrPauseButton响应事件
    [_bottomView.playOrPauseButton addTarget:self action:@selector(playOrPauseButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加nextSongButton响应事件
    [_bottomView.nextSongButton addTarget:self action:@selector(nextButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加preButton响应事件
    [_bottomView.preSongButtton addTarget:self action:@selector(preButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加shuffleAndRepeat响应事件
    [_bottomView.playModeButton addTarget:self action:@selector(shuffleAndRepeat) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加songListButton响应事件
    [_bottomView.songListButton addTarget:self action:@selector(songListButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    // 播放进度条添加响应事件
    [_bottomView.songSlider addTarget:self //事件委托对象
                               action:@selector(playbackSliderValueChanged) //处理事件的方法
                     forControlEvents:UIControlEventValueChanged//具体事件
     ];
    [_bottomView.songSlider addTarget:self //事件委托对象
                               action:@selector(playbackSliderValueChangedFinish) //处理事件的方法
                     forControlEvents:UIControlEventTouchUpInside//具体事件
     ];
   
    self.timer =  [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    [self.timer setFireDate:[NSDate distantPast]];  //很远的将来
}

-(void)nextButtonAction{
    
}
-(void)preButtonAction{
    
}
-(void)shuffleAndRepeat{
    
}
-(void)songListButtonAction{
    
}
#pragma mark - 状态恢复
-(void) playStateRecover {
    
    if (HgMusicPlayerManager.shared.play.rate == 1) {
        [_bottomView.playOrPauseButton setImage:[UIImage imageNamed:@"暂停"] forState:UIControlStateNormal];
        [_bottomView.playOrPauseButton setImage:[UIImage imageNamed:@"暂停（高亮）"] forState:UIControlStateHighlighted];
      
        
    } else {
        [_bottomView.playOrPauseButton setImage:[UIImage imageNamed:@"播放"] forState:UIControlStateNormal];
        [_bottomView.playOrPauseButton setImage:[UIImage imageNamed:@"播放（高亮）"] forState:UIControlStateHighlighted];
    }
     [self.timer setFireDate:[NSDate distantPast]];
}
#pragma - mark 进度条改变值时触发
//拖动进度条改变值时触发
-(void) playbackSliderValueChanged {
    // 更新播放时间
    CMTime duration = HgMusicPlayerManager.shared.play.currentItem.asset.duration;
    
    // 歌曲总时间和当前时间
    Float64 completeTime = CMTimeGetSeconds(duration);
    Float64 currentTime = (Float64)(_bottomView.songSlider.value);
    
//    float current = self.second/self.audioRes.courseMediaDuration;
//    self.bottomView.songSlider.value = current;
//    NSInteger minute = self.second/60;
//    NSInteger ss = self.second%60;
//    self.bottomView.currentTimeLabel.text = [NSString stringWithFormat:@"%.2ld:%.2ld",minute,ss];
    NSInteger current = currentTime;
    self.second = current;
    NSInteger minute = self.second/60;
    NSInteger ss = self.second%60;
    self.bottomView.currentTimeLabel.text = [NSString stringWithFormat:@"%.2ld:%.2ld",minute,ss];
    //播放器定位到对应的位置
    CMTime targetTime = CMTimeMake((int64_t)(currentTime), 1);
    [HgMusicPlayerManager.shared.play seekToTime:targetTime];
    
    //如果当前时暂停状态，则自动播放
    if (HgMusicPlayerManager.shared.play.rate == 0) {
        
        [_bottomView.playOrPauseButton setImage:[UIImage imageNamed:@"暂停"] forState:UIControlStateNormal];
        [_bottomView.playOrPauseButton setImage:[UIImage imageNamed:@"暂停（高亮）"] forState:UIControlStateHighlighted];
        
        [HgMusicPlayerManager.shared startPlay];
        [self.timer setFireDate:[NSDate distantPast]]; //很远的过去
        
    }
}
-(void)playbackSliderValueChangedFinish{
    // 更新播放时间
    CMTime duration = HgMusicPlayerManager.shared.play.currentItem.asset.duration;
    
    // 歌曲总时间和当前时间
    Float64 completeTime = CMTimeGetSeconds(duration);
    Float64 currentTime = (Float64)(_bottomView.songSlider.value) ;
    
    //    float current = self.second/self.audioRes.courseMediaDuration;
    //    self.bottomView.songSlider.value = current;
    //    NSInteger minute = self.second/60;
    //    NSInteger ss = self.second%60;
    //    self.bottomView.currentTimeLabel.text = [NSString stringWithFormat:@"%.2ld:%.2ld",minute,ss];
    NSInteger current = currentTime;
    self.second = current;
    NSInteger minute = self.second/60;
    NSInteger ss = self.second%60;
    self.bottomView.currentTimeLabel.text = [NSString stringWithFormat:@"%.2ld:%.2ld",minute,ss];
    //播放器定位到对应的位置
    CMTime targetTime = CMTimeMake((int64_t)(currentTime), 1);
    [HgMusicPlayerManager.shared.play seekToTime:targetTime];
   
    //如果当前时暂停状态，则自动播放
    if (HgMusicPlayerManager.shared.play.rate == 0) {
        
        [_bottomView.playOrPauseButton setImage:[UIImage imageNamed:@"暂停"] forState:UIControlStateNormal];
        [_bottomView.playOrPauseButton setImage:[UIImage imageNamed:@"暂停（高亮）"] forState:UIControlStateHighlighted];
        
        [HgMusicPlayerManager.shared startPlay];
        [self.timer setFireDate:[NSDate distantPast]]; //很远的过去
        
    }
}
#pragma - mark 播放或暂停
-(void) playOrPauseButtonAction {
    if (HgMusicPlayerManager.shared.play.rate == 0) {
        [_bottomView.playOrPauseButton setImage:[UIImage imageNamed:@"暂停"] forState:UIControlStateNormal];
        [_bottomView.playOrPauseButton setImage:[UIImage imageNamed:@"暂停（高亮）"] forState:UIControlStateHighlighted];
        [HgMusicPlayerManager.shared startPlay];
        [[HgMusicPlayerManager shared]play:self.audioRes.courseMediaPath];
        
        [self.timer setFireDate:[NSDate distantPast]]; //很远的过去
        
    } else {
        [_bottomView.playOrPauseButton setImage:[UIImage imageNamed:@"播放"] forState:UIControlStateNormal];
        [_bottomView.playOrPauseButton setImage:[UIImage imageNamed:@"播放（高亮）"] forState:UIControlStateHighlighted];
        [HgMusicPlayerManager.shared stopPlay];
        //关闭定时器
         [self.timer setFireDate:[NSDate distantFuture]];  //很远的将来
       
    }
}

#pragma - mark 更新播放时间
-(void) updateTime {
    self.second +=1;
        CMTime duration = HgMusicPlayerManager.shared.play.currentItem.asset.duration;
        
        // 歌曲总时间和当前时间
        Float64 completeTime = CMTimeGetSeconds(duration);
        Float64 currentTime = (Float64)(_bottomView.songSlider.value) * completeTime;
    
    float current = self.second/self.audioRes.courseMediaDuration;
    self.bottomView.songSlider.value = self.second;
    NSInteger minute = self.second/60;
    NSInteger ss = self.second%60;
    self.bottomView.currentTimeLabel.text = [NSString stringWithFormat:@"%.2ld:%.2ld",minute,ss];
        //播放器定位到对应的位置
        CMTime targetTime = CMTimeMake((int64_t)(currentTime), 1);
//        [HgMusicPlayerManager.shared.play seekToTime:targetTime];

   
}

@end

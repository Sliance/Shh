//
//  PromoteQrController.m
//  Shh
//
//  Created by zhangshu on 2018/12/4.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "PromoteQrController.h"
#import "PromoteQrFootView.h"
#import "UIImage+RTStyle.h"
#import "WXApiObject.h"
#import "WXApi.h"
@interface PromoteQrController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *bgscrollow;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)PromoteQrFootView*footView;
@property(nonatomic,strong)UIImageView *QrImage;

@end

@implementation PromoteQrController
-(UIScrollView *)bgscrollow{
    if (!_bgscrollow) {
        _bgscrollow = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        _bgscrollow.delegate = self;
        _bgscrollow.contentSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT*1.5);
    }
    return _bgscrollow;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = DSColorFromHex(0x969696);
        _titleLabel.text = @"右上角分享，即可邀请！";
    }
    return _titleLabel;
}
-(UIImageView *)QrImage{
    if (!_QrImage) {
        _QrImage = [[UIImageView alloc]initWithFrame:CGRectMake(160-75, 280, 150, 150)];
        //1. 实例化二维码滤镜
        CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
        // 2. 恢复滤镜的默认属性
        [filter setDefaults];
        // 3. 将字符串转换成NSData
        NSString *urlStr = [NSString stringWithFormat:@"https://v2.m.csihe.com/#/csiheLogin%@",[UserCacheBean share].userInfo.memberId];
        NSData *data = [urlStr dataUsingEncoding:NSUTF8StringEncoding];
        // 4. 通过KVO设置滤镜inputMessage数据
        [filter setValue:data forKey:@"inputMessage"];
        // 5. 获得滤镜输出的图像
        CIImage *outputImage = [filter outputImage];
        // 6. 将CIImage转换成UIImage，并显示于imageView上 (此时获取到的二维码比较模糊,所以需要用下面的createNonInterpolatedUIImageFormCIImage方法重绘二维码)
        
        _QrImage.image = [UIImage creatNonInterpolatedUIImageFormCIImage:outputImage withSize:150];//重绘二维码,使其显示清晰

    }
    return _QrImage;
}
-(PromoteQrFootView *)footView{
    if (!_footView) {
        _footView = [[PromoteQrFootView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT-[self tabBarHeight], SCREENWIDTH, [PromoteQrFootView getHeight])];
    }
    return _footView;
}
-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREENWIDTH/2-160, 50, 320, 522)];
        _headImage.image = [UIImage imageNamed:@"extend_bg"];
        
    }
    return _headImage;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.bgscrollow];
    [self.bgscrollow addSubview:self.titleLabel];
    [self.bgscrollow addSubview:self.headImage];
    [self.headImage addSubview:self.QrImage];
    [self.view addSubview:self.footView];
    [self setRightButtonWithIcon:[UIImage imageNamed:@"share_mine"]];
    __weak typeof(self)weakself = self;
    [self.footView setChangeBlock:^(BOOL selected) {
        if (selected ==NO) {
            weakself.footView.titleBtn.selected = YES;
            weakself.footView.frame = CGRectMake(0, SCREENHEIGHT-[PromoteQrFootView getHeight], SCREENWIDTH, [PromoteQrFootView getHeight]);
        }else if (selected == YES){
            weakself.footView.titleBtn.selected = NO;
            weakself.footView.frame = CGRectMake(0, SCREENHEIGHT-[self tabBarHeight], SCREENWIDTH, [PromoteQrFootView getHeight]);
        }
    }];
    
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = DSColorFromHex(0xF0F0F0);
        [self setTitle:@"推广二维码"];
        
    }
    return self;
}
-(void)didRightClick{
    UIGraphicsBeginImageContextWithOptions(self.headImage.bounds.size, NO, 0.0f);
    [self.headImage.layer renderInContext: UIGraphicsGetCurrentContext()];
    UIImage* viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    NSData* imageData = UIImageJPEGRepresentation(viewImage, 0.7);
    
    WXImageObject *imageObject = [WXImageObject object];
    imageObject.imageData = imageData;
    
    WXMediaMessage *message = [WXMediaMessage message];
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"res5"
//                        imageData;
    message.mediaObject = imageObject;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    [WXApi sendReq:req];
}
@end

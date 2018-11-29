//
//  AgreeMentController.m
//  Shh
//
//  Created by zhangshu on 2018/11/28.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "AgreeMentController.h"

@interface AgreeMentController ()<UIScrollViewDelegate>


@property(nonatomic,strong)UIScrollView *bgScrollow;


@end

@implementation AgreeMentController
-(UIScrollView *)bgScrollow{
    if (!_bgScrollow) {
        _bgScrollow = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        _bgScrollow.delegate = self;
        _bgScrollow.contentSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT*6);
    }
    return _bgScrollow;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.bgScrollow];
    [self creatUI];
}

-(void)creatUI{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SCREENWIDTH, 14)];
    titleLabel.text = @"服务协议";
    titleLabel.font = [UIFont  systemFontOfSize:14];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = DSColorFromHex(0x464646);
    [self.bgScrollow addSubview:titleLabel];
   
    NSString *content = @"欢迎申请并使用思和创投管理咨询（北京）有限公司旗下品牌思和会（下列简称“思和会”或“本公司”）所提供的服务。请您（以下又称为“用户”）仔细阅读以下全部内容（特别是以粗体下划线标注的内容）。如用户不同意本服务协议的任意内容，请勿注册或使用思和会服务。如用户通过进入注册程序，即表示用户与本公司已达成协议，自愿接受本服务协议的所有内容。此后，用户不得以未阅读、或不了解本服务协议内容作任何形式的抗辩。\n\n 1. 服务条款的确认、接纳及修改\n\n思和会服务涉及到的所有产品的所有权以及相关软件的知识产权归本公司所有。本服务协议的效力范围及于本公司所提供的一切产品和服务，用户在享受本公司任何单项服务时，应当受本服务协议的约束。\n\n当用户使用思和会针对各特定课程所提供的单项服务时(以下简称“单项服务” )，应以本公司认可的方式同意该单项服务的服务条款以及本公司在该单项服务中发出的各类公告信息(下列简称“单项条款”），在此情况下单项条款与本服务协议同时对用户产生效力。若单项条款与本服务协议存在任何冲突或不一致的，则在单项条款约束范围内应以单项条款为准。\n\n本公司有权在必要时通过在网页上发出公告等合理方式修改本服务协议以及各单项服务的相关条款。用户在享受各项服务时，应当及时查阅了解最新修改的内容，并自觉遵守本服务协议以及该单项服务的相关条款。用户如继续使用本服务协议涉及的服务，则视为对修改内容的同意和接受，当发生有关争议时，以最新的服务协议为准；用户在不同意修改内容的情况下，有权停止使用本服务协议涉及的服务。若您仍继续使用思和会服务的，即视为您已了解并完全同意修改后的各项协议内容。\n\n2. 服务内容、范围\n\n思和会目前向用户提供的服务包括但不限于观看视频、签署协议、购买课程、获取直播课程信息准时参加直播课程学习、获取相关学习资料等。本公司运用自己的信息网络渠道通过国际互联网络为用户提供各项服务。用户必须：\n\n(1) 自备相关设备，如个人电脑、手机或其他上网设备等；\n\n(2) 承担个人上网相关的费用。\n\n3. 思和会用户账号注册规则\n\n(1) 帐号注册资料包括用户提交录入的姓名、手机号码、密码、注册或更新思和会帐号时输入的所有信息以及用户使用思和会各单项服务时输入、提供的所有信息。\n\n(2) 用户在注册思和会帐号时承诺遵守法律法规、国家利益、公民合法权益、公共秩序、社会主义道德和信息真实性等原则，不得在思和会帐号注册资料中出现违法和不良信息，且用户保证其在注册和使用帐号时，不得有以下情形：\n\n1) 违反宪法或法律法规规定的；\n\n2) 危害国家安全，泄露国家秘密，颠覆国家政权，破坏国家统一的；\n\n3) 损害国家荣誉和利益的，损害公共利益的；\n\n4) 煽动民族仇恨、民族歧视，破坏民族团结的；\n\n5) 破坏国家宗教政策，宣扬邪教和封建迷信的；\n\n6) 散布谣言，扰乱社会秩序，破坏社会稳定的；\n\n7) 散布淫秽、色情、赌博、暴力、凶杀、恐怖或者教唆犯罪的；\n\n8) 侮辱或者诽谤他人，侵害他人合法权益的；\n\n9) 含有法律、行政法规禁止的其他内容的。\n\n(3) 您同意遵守中华人民共和国相关法律法规的所有规定，并对以任何通过您的密码和您的帐号来使用思和会服务的任何行为及其结果承担全部责任。如您的行为违反国家法律和法规的任何规定，有可能构成违法犯罪的，您将被追究法律责任，同时本公司亦有权不经任何事先通知而暂停、或终止向您提供服务。\n\n(4) 用户同意，其提供的真实、准确、合法的思和会帐号注册资料是作为认定用户个体与其思和会帐号的关联性以及用户身份确认的唯一证据。本公司提醒用户，用户注册思和会帐号或更新注册信息时所填写的相关内容，在注册思和会帐号成功或补充填写成功后若再行修改的，本公司出于安全考虑将设置相关的修改程序，因此请用户慎重填写提交各类注册信息。若本公司有合理理由怀疑您提交的相关资料或信息属于恶意程序或恶意操作，则本公司有权暂停或终止向您的帐号提供服务，并有权拒绝您于现在和将来使用本公司所提供服务之全部或任何部分。\n\n(5) 为使用户及时、全面了解本公司提供的各项服务，用户同意，本公司可以多次、长期向用户发送各类商业性短信息、邮件而无需另行获得用户的特别同意。\n\n(6) 用户同意与注册、使用思和会帐号相关的一切资料、数据和记录，包括但不限于思和会帐号、注册资料、所有登录和操作记录和相关的使用统计数字、产品客户服务记录等归上海知行明德投资管理顾问有限公司所有。发生争议时，用户同意以上海知行明德投资管理顾问有限公司的系统数据为准，上海知行明德投资管理顾问有限公司保证该数据的真实性。\n\n4. 帐号、密码及相关安全注意事项\n\n在完成思和会要求的注册程序并成功注册之后，您可使用您的账号和密码，登录并使用思和会向您提供的各项服务。保护您的帐号安全，是思和会的责任、同时亦是您自身的义务。\n\n您应对您所有通过帐号及密码所做的操作、所进行的活动负完全的责任。您同意：\n\n(1) 一旦发现您的思和会帐号遭到未获授权的使用，或者发生其它任何安全问题时，您将立即通知思和会；\n\n(2) 一旦思和会发现您的账户存在异常状况的(包括但不限于异地登陆、IP地址异常变动、发送注册信息变更请求等)，则思和会有权依据其合理判断采取相应措施(包括但不限于要求用户进行实名认证等)以保护用户账号安全；\n\n(3) 若您未保管好自己的帐号和密码，因此而产生的任何损失或损害，思和会不应承担任何责任；因此对您、思和会或其他第三方造成任何损害的，将由您负全部责任。\n\n5. 思和会隐私政策\n\n您提供的注册登记资料及由思和会保留的有关您的若干其它资料将受到中国有关隐私保护的法律法规以及本公司《隐私条款》(详情请见本公司官网)之保护及规范。\n\n6. 知识产权保护\n\n本公司向用户提供的服务包括但不限于：文字、软件、图片、图表、音频、视频等。所有这些内容均属于思和会所有，并受版权、商标、专利和其它财产所有权法律的保护。所以，用户只能在本公司授权下才能为自用目的合理使用这些内容，而不能擅自复制、再造这些内容、或创造与这些内容有关的衍生作品或产品。\n\n思和会等，以及本公司的其他标志及产品、服务的名称，均为本公司之商业标识（以下简称“思和会标识”）。未经本公司事先书面同意，您不得将思和会标识以任何方式展示或使用或作其他处理，也不得向他人表明或误导他人相信您有权展示、使用、或其他有权处理思和会标识。\n\n同时，本公司尊重知识产权并注重保护用户享有的各项权利。在本公司提供服务过程中，用户可能需要通过上传、发布等各种方式向本公司或通过思和会提供相关内容(包括但不限于用户通过本公司或本公司授权人员享有处置权之BBS、电子公告牌、即时通信工具及聊天群、组等)。在此情况下，用户仍然享有此等内容的完整知识产权。用户在提供内容时将授予本公司一项全球性的免费许可，即允许本公司使用、传播、复制、修改、再许可、翻译、创建衍生作品、出版、表演及展示此等内容。";
    UILabel *contentLabel = [[UILabel alloc]init];
    [contentLabel setText:content lineSpacing:5];
    contentLabel.frame = CGRectMake(15, 50, SCREENWIDTH-30,[contentLabel getHeightLineWithString:content withWidth:SCREENWIDTH-30 withFont:[UIFont systemFontOfSize:14] lineSpacing:5]);
    contentLabel.font = [UIFont  systemFontOfSize:14];
    contentLabel.textColor = DSColorFromHex(0x464646);
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.numberOfLines =0;
    [self.bgScrollow addSubview:contentLabel];
    self.bgScrollow.contentSize = CGSizeMake(SCREENWIDTH, contentLabel.ctBottom+100);
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
       
        self.title = @"服务详情";
    }
    return self;
}

@end

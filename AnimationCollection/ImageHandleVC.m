//
//  ImageHandleVC.m
//  AnimationCollection
//
//  Created by 马浩哲 on 2017/3/20.
//  Copyright © 2017年 junanxin. All rights reserved.
//

#import "ImageHandleVC.h"
#import "UIImage+ImageEffects.h"
#import "BlurDownloadView.h"

@interface ImageHandleVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;

@property (nonatomic, strong) UIImage *blurImage;
@end

@implementation ImageHandleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"动画收集";
    
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kDeviceWidth, kDeviceHeight - 64)];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    [self.view addSubview:_tableview];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellId";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    
    if (indexPath.row == 0) {
        UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 201, 256)];
//        imageView.image = [self vagueWithCoreImage];//卡顿
//        [cell.contentView addSubview:imageView];
    }else if (indexPath.row == 1){
        UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 201, 256)];
        imageView.image = [self vagueWithImageEffects];//流畅一点
        [cell.contentView addSubview:imageView];
    }else if (indexPath.row == 2){
        [cell.contentView addSubview:[self vagueWithUIVisualEffectView]];
    }else if (indexPath.row == 3){
        [cell.contentView addSubview:[self loadBlurImageView]];
    }else if (indexPath.row == 4){
        [cell.contentView addSubview:[self maskWithCAGradientLayerView]];
    }else if (indexPath.row == 5){
        [cell.contentView addSubview:[self changeViewsWithMaskView]];
    }
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3) {
        return 512;
    }
    else
    {
        return 256;
    }
}


#pragma mark - coreImage 模糊
-(UIImage *)vagueWithCoreImage
{
    //原始图片
    UIImage *image = [UIImage imageNamed:@"myImage"];
    
    /* ---------coreImage部分-------- */
    //CIImage
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    
    //CIFilter
    CIFilter *blurFultre = [CIFilter filterWithName:@"CIGaussianBlur"];
    
    //将图片输入到滤镜当中
    [blurFultre setValue:ciImage forKey:kCIInputImageKey];
    
    //设置模糊程度
    [blurFultre setValue:@(10) forKey:@"inputRadius"];
    
    //用来查询滤镜可以设置的参数以及一些相关信息
//    NSLog(@"%@",[blurFultre attributes]);
    
    //将处理好的图片输出
    CIImage *outCIImage = [blurFultre valueForKey:kCIOutputImageKey];
    
    //CiContext
    CIContext *context = [CIContext contextWithOptions:nil];//这么写是用CPU渲染，将后边的字典加上属性可以使用GPU渲染
    
    //获取CGImage句柄
    CGImageRef outCGIamge = [context createCGImage:outCIImage fromRect:[outCIImage extent]];
    
    //最终获取图片
    UIImage *blurImage = [UIImage imageWithCGImage:outCGIamge];
    
    //释放句柄
    CGImageRelease(outCGIamge);
    
    return blurImage;
}

#pragma mark - 通过ImageEffects三方库实现模糊效果
//这种方法渲染速度更快一点，上边一种明显比较卡
-(UIImage *)vagueWithImageEffects
{
    UIImage *image = [UIImage imageNamed:@"myImage"];
    
    _blurImage = [image blurImageWithRadius:10];
    
    return _blurImage;
}

#pragma mark - 通过UIVisualEffectView 实现模糊效果,渲染速度更快，可以实现动态渲染;不过iOS8以后才能用
-(UIView *)vagueWithUIVisualEffectView
{
    
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 256)];
    UIScrollView *baseScrollView = [[UIScrollView alloc] initWithFrame:baseView.bounds];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"myImage"]];
    baseScrollView.contentSize = imageView.image.size;
    baseScrollView.bounces = NO;
    [baseScrollView addSubview:imageView];
    [baseView addSubview:baseScrollView];
    
    /*添加模糊效果*/
    
    //创建模糊View
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    
    //设定尺寸
    effectView.frame = CGRectMake(0, 100, kDeviceWidth, 100);
    
    //添加到view当中
    [baseView addSubview:effectView];
    
    //添加文本提示
    UILabel *label = [[UILabel alloc] initWithFrame:effectView.bounds];
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"模糊效果";
    
    //添加模糊子view
    UIVisualEffectView *subEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIVibrancyEffect effectForBlurEffect:(UIBlurEffect *)effectView.effect]];
    
    //设定尺寸
    subEffectView.frame = effectView.bounds;
    
    //将自模糊view 添加到effectview的contentview当中
    [effectView.contentView addSubview:subEffectView];
    
    //添加要显示的view
    [subEffectView.contentView addSubview:label];
    
    return baseView;
}
#pragma mark - 加载模糊图片
-(BlurDownloadView *)loadBlurImageView
{   
    BlurDownloadView *loadView = [[BlurDownloadView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 512)];
    loadView.pictureUrlStr = @"http://pic33.nipic.com/20131007/2309134_123021284000_2.jpg";
    loadView.contentMode = UIViewContentModeScaleAspectFill;
    [loadView startProgress];
    return loadView;
}

#pragma mark - CAGradientLayer创建模糊效果
-(UIView *)maskWithCAGradientLayerView
{
    UIView *baseView       = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                      0,      kDeviceWidth,
                                                                      256)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20,
                                                                           20,
                                                                           200,
                                                                           200)];
    imageView.image        = [UIImage imageNamed:@"myImage"];
    
    [baseView addSubview:imageView];
    
    //创建CAGradientLayer
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame            = imageView.bounds;
    gradientLayer.colors           = @[(__bridge id)[UIColor clearColor].CGColor,
                                       (__bridge id)[UIColor blackColor].CGColor,
                                       (__bridge id)[UIColor clearColor].CGColor];
    
    gradientLayer.locations        = @[@(0.25),@(0.5),@(0.75)];
    gradientLayer.startPoint       = CGPointMake(0, 0);
    gradientLayer.endPoint         = CGPointMake(1, 0);
    
    //容器View 用于加载创建出来的CAGradientLayer
    UIView *containerView = [[UIView alloc] initWithFrame:imageView.bounds];
    [containerView.layer addSublayer:gradientLayer];
    
    //设定maskView
    imageView.maskView    = containerView;
    
    CGRect frame          = containerView.frame;
    frame.origin.x       -= 200;
    
//    重新复制
    containerView.frame   = frame;
    
//    给maskView 添加动画
    [UIView animateWithDuration:3.f animations:^{
        CGRect frame        = containerView.frame;
        frame.origin.x     += 400;
        
        //重新赋值
        containerView.frame = frame;
    }];
    
    return baseView;
}

#pragma mark - 利用maskView 实现view的切换效果
-(UIView *)changeViewsWithMaskView
{
    UIView *baseViw              = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                               0,
                                                               kDeviceWidth,
                                                               256)];
    
    UIImageView *firstImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(20,
                                                                                20,
                                                                                200,
                                                                                200)];
    firstImageView.image         = [UIImage imageNamed:@"myImage"];
    [baseViw addSubview:firstImageView];
    
    UIImageView *secondImageView = [[UIImageView alloc] initWithFrame:firstImageView.frame];
    secondImageView.image        = [UIImage imageNamed:@"twoImage"];
    [baseViw addSubview:secondImageView];
    
    //创建CAGradientLayer
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame            = CGRectMake(0, 0, 200, 200);
    gradientLayer.colors           = @[(__bridge id)[UIColor blackColor].CGColor,
                                       (__bridge id)[UIColor blackColor].CGColor,
                                       (__bridge id)[UIColor clearColor].CGColor];
    gradientLayer.locations        = @[@(0.25f),@(0.5),@(.75f)];
    gradientLayer.startPoint       = CGPointMake(0, 0);
    gradientLayer.endPoint         = CGPointMake(1, 1);
    
    //添加CAGradientLayer的容器
    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    [maskView.layer addSublayer:gradientLayer];
    
    //设定imgaeview的maskView
    secondImageView.maskView = maskView;
    
    //设定动画
    CGRect tempFrame = maskView.frame;
    tempFrame.origin.x -= 200;
    
    maskView.frame = tempFrame;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:3.f animations:^{
            CGRect tempFrame    = maskView.frame;
            tempFrame.origin.x += 300;
            
            maskView.frame = tempFrame;
        }];
    });
    
    return baseViw;
}

@end

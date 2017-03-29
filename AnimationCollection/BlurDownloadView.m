//
//  BlurDownloadView.m
//  AnimationCollection
//
//  Created by 马浩哲 on 2017/3/22.
//  Copyright © 2017年 junanxin. All rights reserved.
//

#import "BlurDownloadView.h"
#import "UIImage+ImageEffects.h"
#import "GCD.h"

@interface BlurDownloadView ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation BlurDownloadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self loadSubViews];
        self.alpha = 0.f;
    }
    return self;
}

//初始化控件
-(void)loadSubViews
{
    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:_imageView];
}



-(void)startProgress
{
    if (_pictureUrlStr) {
        
        [GCDQueue executeInGlobalQueue:^{
            //创建请求
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_pictureUrlStr]];
            //因为是同步请求，会阻塞主线程
            NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            
            //获取图片
            UIImage *image = [UIImage imageWithData:data];
            
            //对图片进行模糊处理
            UIImage *blurImage = [image blurImage];
            
            [GCDQueue executeInMainQueue:^{
                //加载图片
                _imageView.image = blurImage;
                [UIView animateWithDuration:.5f animations:^{
                    self.alpha = 1.f;
                }];
            }];
        }];
    }
}

@synthesize contentMode = _contentMode;
-(void)setContentMode:(UIViewContentMode)contentMode
{
    _contentMode = contentMode;
    self.imageView.contentMode = contentMode;
}

-(UIViewContentMode)contentMode
{
    return _contentMode;
}

@end

//
//  WaveView.m
//  AnimationCollection
//
//  Created by 马浩哲 on 16/12/13.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#import "WaveView.h"

typedef NS_ENUM(NSInteger, WavePathType)
{
    WavePathType_Sin,
    WavePathType_Cos
};

@interface WaveView ()

@property (nonatomic, strong) UIImageView *garyImageView;
@property (nonatomic, strong) UIImageView *sineImageView;
@property (nonatomic, strong) UIImageView *cosineImageView;
@property (nonatomic, strong) CAShapeLayer *waveSinLayer;
@property (nonatomic, strong) CAShapeLayer *waveCosLayer;
@property (nonatomic, strong) CADisplayLink *displayLink;

//波浪相关的参数
@property (nonatomic, assign) CGFloat waveWidth;//计算出单位间距1pixel代表的度数
@property (nonatomic, assign) CGFloat waveHeight;
@property (nonatomic, assign) CGFloat waveMid;
@property (nonatomic, assign) CGFloat maxAmplitude;//波峰值
@property (nonatomic, assign) CGFloat frequency;//角速度

@property (nonatomic, assign) CGFloat phaseShif;
@property (nonatomic, assign) CGFloat phase;//用于计算初相

@end

@implementation WaveView

static CGFloat kWavePositionDuration = 10;

+(instancetype)loadingView
{
    return [[WaveView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

-(CGSize)intrinsicContentSize
{
    return CGSizeMake(200, 200);
}

#pragma mark - 开始加载
-(void)startLoading
{
    [_displayLink invalidate];
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateWave:)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
    CGPoint posintion = self.waveSinLayer.position;
    posintion.y = posintion.y - self.bounds.size.height - 10;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:self.waveSinLayer.position];
    animation.toValue = [NSValue valueWithCGPoint:posintion];
    animation.duration = kWavePositionDuration;
    animation.repeatCount = HUGE_VALL;
    animation.removedOnCompletion = NO;
    [self.waveSinLayer addAnimation:animation forKey:@"positionWave"];
    [self.waveCosLayer addAnimation:animation forKey:@"positionWave"];
}

-(void)stopLoading
{
    [self.displayLink invalidate];
    [self.waveSinLayer removeAllAnimations];
    [self.waveCosLayer removeAllAnimations];
    self.waveCosLayer.path = nil;
    self.waveSinLayer.path = nil;
}

#pragma mark - 设置图形属性
-(void)setupSubViews
{
    self.waveSinLayer = [CAShapeLayer layer];
    self.waveSinLayer.backgroundColor = [UIColor clearColor].CGColor;
    self.waveSinLayer.fillColor = [UIColor greenColor].CGColor;
    self.waveSinLayer.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, self.bounds.size.height);
    
    self.waveCosLayer = [CAShapeLayer layer];
    self.waveCosLayer.backgroundColor = [UIColor clearColor].CGColor;
    self.waveCosLayer.fillColor = [UIColor blueColor].CGColor;
    self.waveCosLayer.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, self.bounds.size.height);
    
    self.waveHeight = CGRectGetHeight(self.bounds) * 0.5;
    self.waveWidth = CGRectGetWidth(self.bounds);
    self.frequency = .3;
    self.phaseShif = 6;
    self.waveMid = self.waveWidth/2.0f;
    self.maxAmplitude = self.waveHeight * .3;
    
    self.garyImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.garyImageView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
    
    self.garyImageView.layer.cornerRadius = 100;
    self.garyImageView.layer.masksToBounds = YES;
    [self addSubview:self.garyImageView];
    
    self.sineImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.sineImageView.backgroundColor = [UIColor lightGrayColor];
    self.sineImageView.layer.cornerRadius = 100;
    self.sineImageView.layer.masksToBounds = YES;
    [self addSubview:self.sineImageView];
    
    self.cosineImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.cosineImageView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
    self.cosineImageView.layer.cornerRadius = 100;
    self.cosineImageView.layer.masksToBounds = YES;
    self.cosineImageView.backgroundColor = [UIColor greenColor];
    [self addSubview:self.cosineImageView];
    
    _sineImageView.layer.mask = _waveSinLayer;
    _cosineImageView.layer.mask = _waveCosLayer;
    
}

#pragma mark - 更新波浪
-(void)updateWave:(CADisplayLink *)displayLink
{
    self.phase += self.phaseShif;
    self.waveSinLayer.path = [self createWavePathWithType:WavePathType_Sin].CGPath;
    self.waveCosLayer.path = [self createWavePathWithType:WavePathType_Cos].CGPath;
}

#pragma mark - 创建正弦余弦曲线
-(UIBezierPath *)createWavePathWithType:(WavePathType)pathType
{
    UIBezierPath *wavePath = [UIBezierPath bezierPath];
    CGFloat endX = 0;
    for (CGFloat x = 0; x < self.waveWidth + 1; x+=1) {
        endX = x;
        CGFloat y = 0;
        if (pathType == WavePathType_Sin)
        {
            y = self.maxAmplitude * sinf(360.0 / _waveWidth * (x * M_PI /180) * self.frequency + self.phase * M_PI/180) + self.maxAmplitude;
        }
        else
        {
            y = self.maxAmplitude * cosf(360.0 / _waveWidth * (x * M_PI / 180) *self.frequency + self.phase * M_PI/180) + self.maxAmplitude;
        }
        
        if (x == 0) {
            [wavePath moveToPoint:CGPointMake(x, y)];
        } else {
            [wavePath addLineToPoint:CGPointMake(x, y)];
        }
    }
    
    CGFloat endY = CGRectGetHeight(self.bounds) + 10;
    [wavePath addLineToPoint:CGPointMake(endX, endY)];
    [wavePath addLineToPoint:CGPointMake(0, endY)];
    
    return wavePath;
    
}

@end

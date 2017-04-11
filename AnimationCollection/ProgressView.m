//
//  ProgressView.m
//  AnimationCollection
//
//  Created by 马浩哲 on 2017/4/10.
//  Copyright © 2017年 junanxin. All rights reserved.
//

#import "ProgressView.h"
#import "UIView+help.h"
#import "POP.h"
#import "PopNumberAnimation.h"
#import "GCD.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)  // 角度转弧度
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))    // 弧度转角度

#define PROGREESS_WIDTH 210 //直径
#define PROGREESS_LINE_WIDTH 18 //弧线宽度

#define ANIMATIONTIME 2.f

@interface ProgressView ()<POPNumberAnimationDelegate>

@property (nonatomic, strong) CAShapeLayer *bgLayer;

@property (nonatomic, strong) CAShapeLayer *frontLayer;

@property (nonatomic, strong) UILabel *numberLabel;

@property (nonatomic, strong) PopNumberAnimation *numAnimation;

@property (nonatomic, strong) GCDTimer *timer;

@end

@implementation ProgressView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self loadProgressView];
        
        [self loadNumLabel];
    }
    
    return self;
}


//创建进度条
-(void)loadProgressView
{
    _bgLayer = [CAShapeLayer layer];
    _bgLayer.frame = self.bounds;
    [self.layer addSublayer:_bgLayer];
    _bgLayer.fillColor = [[UIColor clearColor] CGColor];
    _bgLayer.strokeColor = [[UIColor lightGrayColor] CGColor];
    _bgLayer.opacity = 0.25;
    _bgLayer.lineDashPattern = @[@(2),@(6)];
    _bgLayer.lineWidth = PROGREESS_LINE_WIDTH;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(120, 120) radius:(PROGREESS_WIDTH-PROGREESS_LINE_WIDTH)/2 startAngle:DEGREES_TO_RADIANS(-225) endAngle:DEGREES_TO_RADIANS(45) clockwise:YES];
    _bgLayer.path =[path CGPath];
    
    
    _frontLayer = [CAShapeLayer layer];
    _frontLayer.frame = self.bounds;
    _frontLayer.fillColor =  [[UIColor clearColor] CGColor];
    _frontLayer.strokeColor  = [[UIColor whiteColor] CGColor];
    _frontLayer.lineDashPattern = @[@(2),@(6)];
    _frontLayer.lineWidth = PROGREESS_LINE_WIDTH;
    _frontLayer.path = [path CGPath];
    _frontLayer.strokeEnd = 0;
    
    CALayer *gradientLayer = [CALayer layer];
    
    CAGradientLayer *gradientLayer1 =  [CAGradientLayer layer];
    gradientLayer1.frame = CGRectMake(0, 0, self.width/2, self.height);
    [gradientLayer1 setColors:[NSArray arrayWithObjects:(id)[[UIColor colorWithRed:40/255.0 green:187/255.0 blue:177/255.0 alpha:1.0] CGColor],(id)[[UIColor colorWithRed:173/255.0 green:89/255.0 blue:162/255.0 alpha:1.0] CGColor], nil]];
    [gradientLayer1 setLocations:@[@0.3,@1,@1 ]];
    [gradientLayer1 setStartPoint:CGPointMake(0.5, 1)];
    [gradientLayer1 setEndPoint:CGPointMake(0.5, 0)];
    [gradientLayer addSublayer:gradientLayer1];
    
    CAGradientLayer *gradientLayer2 =  [CAGradientLayer layer];
    [gradientLayer2 setLocations:@[@0,@0.7,@1]];
    gradientLayer2.frame = CGRectMake(self.width/2, 0, self.width/2, self.height);
    [gradientLayer2 setColors:[NSArray arrayWithObjects:(id)[[UIColor colorWithRed:173/255.0 green:89/255.0 blue:162/255.0 alpha:1.0] CGColor],(id)[[UIColor colorWithRed:125/255.0 green:105/255.0 blue:255/255.0 alpha:1.0] CGColor], nil]];
    [gradientLayer2 setStartPoint:CGPointMake(0.5, 0)];
    [gradientLayer2 setEndPoint:CGPointMake(0.5, 1)];
    [gradientLayer addSublayer:gradientLayer2];
    
    [gradientLayer setMask:_frontLayer]; 
    [self.layer addSublayer:gradientLayer];
}

-(void)loadNumLabel
{
    UILabel *kmLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (self.height - 80)/2.0 - 20, self.width, 20)];
    kmLabel.font = [UIFont systemFontOfSize:18];
    kmLabel.text = @"km/h";
    kmLabel.textAlignment = NSTextAlignmentCenter;
    kmLabel.textColor = [UIColor colorWithRed:115/255.0 green:128/255.0 blue:176/255.0 alpha:1.0];
    [self addSubview:kmLabel];
    
    _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (self.height - 80)/2.0, self.width, 80)];
    _numberLabel.textAlignment = NSTextAlignmentCenter;
    _numberLabel.font = [UIFont systemFontOfSize:70];
    _numberLabel.textColor = [UIColor whiteColor];
    _numberLabel.text = @"0";
    [self addSubview:_numberLabel];
    
    
}


//配置动画属性
-(void)configNumberAnimation{
    self.numAnimation.fromValue = self.numAnimation.currentValue;
    self.numAnimation.toValue   = self.persent;
    self.numAnimation.duration  = ANIMATIONTIME;
//    self.numAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.69 :0.11 :0.32 :0.88];
    self.numAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.numAnimation saveValues];
}

//numberAnimation 代理方法
-(void)POPNumberAnimationWithCurrentValue:(CGFloat)currentValue animation:(PopNumberAnimation *)popAnimation{
    
    NSString *numStr = [NSString stringWithFormat:@"%.0f",currentValue];
    
    _numberLabel.text = numStr;
    
    if (currentValue == self.persent) {
        [self.timer destroy];
    }
}

//设置百分比
-(void)setPersent:(CGFloat)persent
{
    [CATransaction begin];
    [CATransaction setDisableActions:NO];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [CATransaction setAnimationDuration:ANIMATIONTIME];
    
    _frontLayer.strokeEnd = persent/100.0;
    [CATransaction commit];
    
    _persent = persent;
    [self loadLineAnimation];
    
    
    
    self.numAnimation = [[PopNumberAnimation alloc] init];
    self.numAnimation.delegate = self;
    
    __weak ProgressView *weakSelf = self;
    
    self.timer = [[GCDTimer alloc] initInQueue:[GCDQueue mainQueue]];
    [self.timer event:^{
        [weakSelf configNumberAnimation];
        [weakSelf.numAnimation startAnimation];
    } timeIntervalWithSecs:ANIMATIONTIME + 0.1];
    [self.timer start];
}



//添加边线动画
-(void)loadLineAnimation
{
    //创建运动的轨迹动画
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = 1.5;
    pathAnimation.repeatCount = 3;
    
    CGFloat origin_x = self.frame.size.width/2;
    CGFloat origin_y = self.frame.size.height/2;
    CGFloat radiusX = 110;
    
    CGMutablePathRef ovalfromarc = CGPathCreateMutable();
    
    CGPathAddArc(ovalfromarc, nil, origin_x, origin_y, radiusX,DEGREES_TO_RADIANS(-225),DEGREES_TO_RADIANS(45), 0);
    pathAnimation.path = ovalfromarc;
    CGPathRelease(ovalfromarc);
    
    //添加运动图形
    float width = 4;
    UIView * aniView = [[UIImageView alloc] init];
    [self addSubview:aniView];
    aniView.frame = CGRectMake(0, 0, width, width);
    [aniView.layer setCornerRadius:width/2];
    aniView.backgroundColor = [UIColor colorWithRed:40/255.0 green:187/255.0 blue:177/255.0 alpha:1.0];
    //设置运转的动画
    [aniView.layer addAnimation:pathAnimation forKey:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [aniView removeFromSuperview];
    });
}
@end

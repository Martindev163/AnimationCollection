//
//  MHZPOPAlertView.m
//  POPDemo
//
//  Created by MaHaoZhe on 2020/3/31.
//  Copyright © 2020 HachiTech. All rights reserved.
//

#import "MHZPOPAlertView.h"
#import "POP.h"

#define MHZPOPAlertViewWidth ([[UIScreen mainScreen] bounds].size.width - 80)

@interface MHZPOPAlertView ()

@property (nonatomic, strong) NSMutableArray *itemArray;//存储非取消按钮

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, copy) cancelBlock myCancelBlock;
@property (nonatomic, copy) otherBlaock myOtherBlock;

@end

@implementation MHZPOPAlertView

-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelBlock:(cancelBlock)cancel otherBlock:(otherBlaock)other cancelButtenTitle:(NSString *)cancelTitle otherButtonTitle:(NSString *)otherTitle, ... NS_REQUIRES_NIL_TERMINATION {
    if (self = [super init]) {
        
        self.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
        self.itemArray = [[NSMutableArray alloc] init];
        
        if (otherTitle.length > 0) {
            //取出第一个参数
            [self.itemArray addObject:otherTitle];
        }
        
        //定义一个指向可变参数的列表指针
        va_list args;
        
        //用于存放取出的参数
        NSString *arg;
        
        //初始化va_list变量，存放可变参数（不包括 otherTitle）
        va_start(args, otherTitle);
        
        //遍历可变参数（第二个参数是可变参数的类型）
        while ((arg = va_arg(args, NSString *))) {
            [self.itemArray addObject:arg];
        }
        
        //清空参数列表，并置参数指针args无效
        va_end(args);
        
        self.myCancelBlock = cancel;
        self.myOtherBlock = other;
        
        [self loadSubviewsWithTtile:title message:message CancelTitle:cancelTitle];
    }
    return self;
}


//加载内容 1.只有取消 2.有取消，有other 3.只有other 4.无取消，无other
-(void)loadSubviewsWithTtile:(NSString *)title message:(NSString *)message CancelTitle:(NSString *)cancel{
    
    CGFloat bgViewHeight = 0.0;
    
    //底板
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MHZPOPAlertViewWidth, 500)];
    _bgView.layer.cornerRadius = 5;
    _bgView.layer.masksToBounds = YES;
    _bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_bgView];
    
    //标题
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _bgView.frame.size.width, 44)];
    titleLab.text = title;
    titleLab.font = [UIFont systemFontOfSize:16];
    titleLab.textColor = [self colorWithHexString:@"#333333" alpha:1.f];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [_bgView addSubview:titleLab];
    
    //分隔线
    UIView *titleLine = [[UIView alloc] initWithFrame:CGRectMake(0, titleLab.frame.size.height-0.5, titleLab.frame.size.width, 0.5)];
    titleLine.backgroundColor = [self colorWithHexString:@"#ececec" alpha:1.f];
    [titleLab addSubview:titleLine];
    
    //获取文本宽度
    CGFloat contentWidth = CGRectGetWidth(_bgView.frame) - 20;
    
    //获取文本高度
    CGFloat contentHeight = [self getString:message lineSpacing:2 font:[UIFont systemFontOfSize:14] width:contentWidth];
    
    // 添加行间距
    NSMutableParagraphStyle * paragraph = [[NSMutableParagraphStyle alloc]init];
    paragraph.lineSpacing = 2.0;
    
    // 字体: 大小 颜色 行间距
    NSAttributedString * attributedStr = [[NSAttributedString alloc]initWithString:message attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[self colorWithHexString:@"#666666" alpha:1.f],NSParagraphStyleAttributeName:paragraph}];
    
    //内容
    UILabel *contentLab = [[UILabel alloc] initWithFrame:CGRectMake(10, titleLab.frame.origin.y + titleLab.frame.size.height + 10, contentWidth, contentHeight)];
    contentLab.numberOfLines = 0;
    contentLab.attributedText = attributedStr;
    [_bgView addSubview:contentLab];
    
    bgViewHeight = contentLab.frame.origin.y + contentLab.frame.size.height + 10;
    
    NSString *cancelStr = @"取消";
    if (cancel.length > 0) {
        cancelStr = cancel;
    }
    
    //多个other按钮
    if (self.itemArray.count > 1) {
        for (int i = 0; i < self.itemArray.count; i++) {
            
            UIButton *otherBtn = [self loadDefaultBtnWithTitle:self.itemArray[i] titleColor:[UIColor whiteColor] bgColor:[self colorWithHexString:@"#3D88F7" alpha:1.f] frame:CGRectMake(0, bgViewHeight + i * 40 + 2, 200, 36) isCenter:YES];
            [otherBtn addTarget:self action:@selector(otherButtonClickWithIndex:) forControlEvents:UIControlEventTouchUpInside];
            otherBtn.tag = i;
            
            [_bgView addSubview:otherBtn];
        }
        
        bgViewHeight = bgViewHeight + self.itemArray.count*40;
        
        //取消按钮
        UIButton *cancelBtn = [self loadDefaultBtnWithTitle:cancelStr titleColor:[UIColor whiteColor] bgColor:[self colorWithHexString:@"#DE1D3F" alpha:1.f] frame:CGRectMake(0, bgViewHeight + 2, 200, 36) isCenter:YES];
        [cancelBtn addTarget:self action:@selector(removeSelf) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:cancelBtn];
        
        bgViewHeight = bgViewHeight + 40 + 10;
        
    }
    
    //一个other按钮
    if (self.itemArray.count == 1) {
        //取消按钮
        UIButton *cancelBtn = [self loadDefaultBtnWithTitle:cancelStr titleColor:[self colorWithHexString:@"#DE1D3F" alpha:1.f] bgColor:[UIColor whiteColor] frame:CGRectMake(0, bgViewHeight + 2, _bgView.frame.size.width/2, 44) isCenter:NO];
        [cancelBtn addTarget:self action:@selector(removeSelf) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:cancelBtn];
        
        UIButton *otherBtn = [self loadDefaultBtnWithTitle:self.itemArray[0] titleColor:[self colorWithHexString:@"#3D88F7" alpha:1.f] bgColor:[UIColor whiteColor] frame:CGRectMake(_bgView.frame.size.width/2, bgViewHeight + 2, _bgView.frame.size.width/2, 44) isCenter:NO];
        [otherBtn addTarget:self action:@selector(otherButtonClickWithIndex:) forControlEvents:UIControlEventTouchUpInside];
        otherBtn.tag = 0;
        [_bgView addSubview:otherBtn];
        
        UIView *Hline = [[UIView alloc] initWithFrame:CGRectMake(0, bgViewHeight, _bgView.frame.size.width, 0.5)];
        Hline.backgroundColor = [self colorWithHexString:@"#ececec" alpha:1.f];
        [_bgView addSubview:Hline];
        
        UIView *Vline = [[UIView alloc] initWithFrame:CGRectMake(_bgView.frame.size.width/2-0.25, bgViewHeight, 0.5, 44)];
        Vline.backgroundColor = [self colorWithHexString:@"#ececec" alpha:1.f];
        [_bgView addSubview:Vline];
        
        bgViewHeight = bgViewHeight + 44;
        
    }
    
    //无other按钮
    if (self.itemArray.count == 0) {
        //取消按钮
        UIButton *cancelBtn = [self loadDefaultBtnWithTitle:cancelStr titleColor:[self colorWithHexString:@"#DE1D3F" alpha:1.f] bgColor:[UIColor whiteColor] frame:CGRectMake(0, bgViewHeight + 2, _bgView.frame.size.width, 44) isCenter:YES];
        [cancelBtn addTarget:self action:@selector(removeSelf) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:cancelBtn];
        
        UIView *Hline = [[UIView alloc] initWithFrame:CGRectMake(0, bgViewHeight, _bgView.frame.size.width, 0.5)];
        Hline.backgroundColor = [self colorWithHexString:@"#ececec" alpha:1.f];
        [_bgView addSubview:Hline];
        
        bgViewHeight = bgViewHeight + 44;
    }
    
    _bgView.frame = CGRectMake(0, 0, MHZPOPAlertViewWidth, bgViewHeight);
    _bgView.center = self.center;
}


//MARK: 交互事件
-(void)showAlert:(BOOL)animation{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    if (animation == YES) {
        [self addAnimationWithType:self.animationType];
    }
}


-(void)removeSelf{
    
    if (self.myCancelBlock) {
        self.myCancelBlock();
    }
    
    [self removeFromSuperview];
}

-(void)remove{
    [self removeFromSuperview];
}


-(void)otherButtonClickWithIndex:(UIButton *)sender{
    if (self.myOtherBlock) {
        self.myOtherBlock(sender.tag);
    }
    [self remove];
}


//MARK: 控件
-(UIButton *)loadDefaultBtnWithTitle:(NSString *)title titleColor:(UIColor *)color bgColor:(UIColor *)bgColor frame:(CGRect)frame isCenter:(BOOL)isCenter{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    btn.backgroundColor = bgColor;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    if (isCenter) {
        btn.layer.cornerRadius = 2;
        
        CGPoint center = btn.center;
        center.x = _bgView.center.x;
        btn.center = center;
    }
    
    return btn;
}


//MARK: 动画
-(void)addAnimationWithType:(MHZPOPAlertViewAnimationType)type{
    if (type == SpringTopToCenterType) {
        POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        spring.fromValue = @(0);
        spring.toValue = @(_bgView.frame.origin.y + _bgView.frame.size.height/2);
        [_bgView pop_addAnimation:spring forKey:@"springAnimation"];
        //振幅
        spring.springBounciness = 12;
        //速度
        spring.springSpeed = 12;
    }else if (type == SpringBottomToCenterType){
        POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        spring.fromValue = @([[UIScreen mainScreen] bounds].size.height);
        spring.toValue = @(_bgView.frame.origin.y + _bgView.frame.size.height/2);
        [_bgView pop_addAnimation:spring forKey:@"springAnimation"];
        //振幅
        spring.springBounciness = 12;
        //速度
        spring.springSpeed = 12;
        
    }else if (type == SpringCenterBouncinesType){
        POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerSize];
        spring.fromValue = [NSValue valueWithCGSize:CGSizeMake(_bgView.frame.size.width-20, _bgView.frame.size.height-20)];
        spring.toValue = [NSValue valueWithCGSize:CGSizeMake(_bgView.frame.size.width, _bgView.frame.size.height)];
        [_bgView pop_addAnimation:spring forKey:@"springAnimation"];
        //振幅
        spring.springBounciness = 10;
        //速度
        spring.springSpeed = 20;
    }
    
}

//MARK: 属性
-(void)setAnimationType:(MHZPOPAlertViewAnimationType)animationType{
    _animationType = animationType;
}

//MARK: 辅助方法

///获取系统默认字符串高度获取如下
- (CGFloat)getStringHeightWithText:(NSString *)text font:(UIFont *)font viewWidth:(CGFloat)width {
    // 设置文字属性 要和label的一致
    NSDictionary *attrs = @{NSFontAttributeName :font};
    CGSize maxSize = CGSizeMake(width, MAXFLOAT);
    
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    // 计算文字占据的宽高
    CGSize size = [text boundingRectWithSize:maxSize options:options attributes:attrs context:nil].size;
    
   // 当你是把获得的高度来布局控件的View的高度的时候.size转化为ceilf(size.height)。
    return  ceilf(size.height);
}


///获取含有行间距的字符串高度
- (CGFloat)getString:(NSString *)string lineSpacing:(CGFloat)lineSpacing font:(UIFont*)font width:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = lineSpacing;
    NSDictionary *dic = @{ NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle };
    CGSize size = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return  ceilf(size.height);
}


///设置RGB颜色
-(UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet  whitespaceAndNewlineCharacterSet]]  uppercaseString];
    //  String should be 6 or 8 characters
    if ([cString length] < 6){
        return [UIColor clearColor];
    }
    //  strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    //  Separate into r,g,b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    //  Scan  values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];

    return
    [UIColor colorWithRed:((float)r/255.0f) green:((float)g/255.0f)  blue:((float)b/255.0f) alpha:alpha];
}


@end

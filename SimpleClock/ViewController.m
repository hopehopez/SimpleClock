//
//  ViewController.m
//  SimpleClock
//
//  Created by zsq on 16/8/29.
//  Copyright © 2016年 zsq. All rights reserved.
//

#import "ViewController.h"

//每一秒旋转速度
#define perSecA 6
#define perMinA 6
#define perHourA 30
#define perMinHourA 0.5

#define angleToRad(angle) ((angle)/180.0*M_PI)

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *colockView;

@property (nonatomic, strong) CALayer *secL;
@property (nonatomic, strong) CALayer *minL;
@property (nonatomic, strong) CALayer *hourL;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setHour];
    [self setMin];
    [self setSec];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    [self timeChange];
}
- (void)timeChange{
   
    NSCalendar *cal = [NSCalendar currentCalendar];
    //
    NSDateComponents *cmp = [cal components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour fromDate:[NSDate date]];
     //获取当前多少秒
    NSInteger curSec = cmp.second + 1;
    NSInteger curMin = cmp.minute ;
    NSInteger curHour = cmp.hour;
    
    //秒针开始旋转
    //计算秒针当前旋转的角度
    //angle = 当前多少秒 * 每一秒旋转多少度.
    CGFloat secA = curSec * perSecA;
    CGFloat minA = curMin * perMinA;
    CGFloat hourA = curHour * perHourA + curMin * perMinHourA;
    self.secL.transform = CATransform3DMakeRotation(angleToRad(secA), 0, 0, 1);
    self.minL.transform = CATransform3DMakeRotation(angleToRad(minA), 0, 0, 1);
    self.hourL.transform = CATransform3DMakeRotation(angleToRad(hourA), 0, 0, 1);
}

//添加秒针
- (void)setSec{
    CALayer *secL = [CALayer layer];
    secL.bounds = CGRectMake(0, 0, 1, 80);
    secL.backgroundColor = [UIColor redColor].CGColor;
    secL.anchorPoint = CGPointMake(0.5, 1);
    secL.position = CGPointMake(self.colockView.bounds.size.width*0.5, self.colockView.bounds.size.height*0.5);
    [self.colockView.layer addSublayer:secL];
    self.secL = secL;
}

//添加分针
- (void)setMin{
    CALayer *minL = [CALayer layer];
    minL.bounds = CGRectMake(0, 0, 3, 60);
    minL.backgroundColor = [UIColor blackColor].CGColor;
    minL.anchorPoint = CGPointMake(0.5, 1);
    minL.position = CGPointMake(self.colockView.bounds.size.width*0.5, self.colockView.bounds.size.height*0.5);
    [self.colockView.layer addSublayer:minL];
    self.minL = minL;
}

//添加时针
- (void)setHour{
    CALayer *hourL = [CALayer layer];
    hourL.bounds = CGRectMake(0, 0, 3, 50);
    hourL.backgroundColor = [UIColor blackColor].CGColor;
    hourL.anchorPoint = CGPointMake(0.5, 1);
    hourL.position = CGPointMake(self.colockView.bounds.size.width*0.5, self.colockView.bounds.size.height*0.5);
    [self.colockView.layer addSublayer:hourL];
    self.hourL = hourL;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  //  self.secL.transform = CATransform3DMakeRotation(M_PI_2, 0, 0, 1);
}
@end

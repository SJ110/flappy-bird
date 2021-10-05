//
//  ViewController.m
//  demo_flappy_bird
//
//  Created by 宋君平 on 2021/10/3.
//

#import "ViewController.h"
#import "bird.h"
#import "gameStartView.h"
#import "gameOverView.h"

#define woodMinHeight 200
#define crossHeight 120
#define floorHeight 112
#define viewWidth [UIScreen mainScreen].bounds.size.width
#define viewHeight [UIScreen mainScreen].bounds.size.height
@interface ViewController () <GameOverViewDelegate,GameStartViewDelegate>
@property (nonatomic, strong) bird *mBird;
@property (nonatomic, strong) UIImageView *bg1;
@property (nonatomic, strong) UIImageView *bg2;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIImageView *woodUp1;
@property (nonatomic, strong) UIImageView *woodDown1;
@property (nonatomic, strong) UIImageView *woodUp2;
@property (nonatomic, strong) UIImageView *woodDown2;
@property (nonatomic, strong) UIImageView *floor1;
@property (nonatomic, strong) UIImageView *floor2;
@property (nonatomic, strong) gameStartView *startView;
@property (nonatomic, strong) gameOverView *overView;
@property (nonatomic, strong) UILabel *sourceLabel;
@property (nonatomic, assign) int source;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatBG];
    [self creatWood];
    [self creatFloor];
    _mBird = [[bird alloc] init];
    _mBird.center = CGPointMake(100, 300);
    [self.view addSubview:_mBird];
    [_mBird startFlying];
    _startView = [[gameStartView alloc] initWithFrame:self.view.frame];
    _overView = [[gameOverView alloc] initWithFrame:self.view.frame];
    _startView.delegate = self;
    _overView.delegate = self;
    [self.view addSubview:_startView];
    [self.view addSubview:_overView];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1/60.0 target:self selector:@selector(updateUI) userInfo:nil repeats:YES];
    _timer.fireDate = [NSDate distantFuture];
    [self creatSourceLabel];
    
}

- (void)creatBG {
    _bg1 = [[UIImageView alloc] initWithFrame:self.view.frame];
    _bg2 = [[UIImageView alloc] initWithFrame:CGRectMake(viewWidth, 0, viewWidth, viewHeight)];
    _bg1.backgroundColor = [UIColor colorWithRed:80.0/255.0 green:(CGFloat)192.0/255.0 blue:203.0/255.0 alpha:1.0];
    _bg2.backgroundColor = [UIColor colorWithRed:80.0/255.0 green:(CGFloat)192.0/255.0 blue:203.0/255.0 alpha:1.0];
    [self.view addSubview:_bg2];
    [self.view addSubview:_bg1];
}

- (void)creatWood {
    _woodUp1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topPipe"]];
    _woodUp2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topPipe"]];
    _woodDown1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bottomPipe"]];
    _woodDown2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bottomPipe"]];
    [self.view addSubview:_woodUp1];
    [self.view addSubview:_woodUp2];
    [self.view addSubview:_woodDown1];
    [self.view addSubview:_woodDown2];
    
    [self makeWoodFrame];
}

- (void)makeWoodFrame {
    CGFloat sH = viewHeight;
    /// 上下柱子至少200 中间空隙120
    int parm = sH-woodMinHeight-crossHeight-woodMinHeight;
    int height = arc4random()%parm+150;
    _woodUp1.frame = CGRectMake(500, 0, 54, height);
    _woodDown1.frame = CGRectMake(500, height+crossHeight, 54, viewHeight-(height+crossHeight));
    
    height = arc4random()%parm;
    _woodUp2.frame = CGRectMake(800, 0, 54, height);
    _woodDown2.frame = CGRectMake(800, height+crossHeight, 54, viewHeight-(height+crossHeight));
}


- (void)creatFloor {
    _floor1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, viewHeight-floorHeight, viewWidth, floorHeight)];
    _floor2 = [[UIImageView alloc ]initWithFrame:CGRectMake(viewWidth, viewHeight-11, viewWidth, floorHeight)];
    _floor1.image = [UIImage imageNamed:@"floor"];
    _floor2.image = [UIImage imageNamed:@"floor"];
    [self.view addSubview:_floor1];
    [self.view addSubview:_floor2];
}

- (void)creatSourceLabel {
    _sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake(viewWidth/2 - 100, 100, 200, 50)];
    _sourceLabel.backgroundColor = [UIColor clearColor];
    _sourceLabel.textAlignment = NSTextAlignmentCenter;
    _sourceLabel.font = [UIFont boldSystemFontOfSize:23];
    _sourceLabel.textColor = [UIColor blackColor];
    _sourceLabel.hidden = YES;
    [self.view addSubview:_sourceLabel];
}

- (void)updateUI {
    float x = _bg1.frame.origin.x;
    if(x<=-viewWidth) {
        /// 背景向左移动至消失
        _bg1.frame = self.view.bounds;
        _bg2.frame = CGRectMake(viewWidth, 0, viewWidth, viewHeight);
        _floor1.frame = CGRectMake(0, viewHeight-floorHeight, viewWidth, floorHeight);
        _floor2.frame = CGRectMake(viewWidth, viewHeight-floorHeight, viewWidth, floorHeight);
    }
    _bg1.frame = CGRectMake(_floor1.frame.origin.x-1, 0, viewWidth, viewHeight);
    _bg2.frame = CGRectMake(_floor2.frame.origin.x-1, 0, viewWidth, viewHeight);
    _floor1.frame = CGRectMake(_floor1.frame.origin.x-1, viewHeight-floorHeight, viewWidth, floorHeight);
    _floor2.frame = CGRectMake(_floor2.frame.origin.x-1, viewHeight-floorHeight, viewWidth, floorHeight);
    _woodUp1.frame = CGRectMake(_woodUp1.frame.origin.x-1, _woodUp1.frame.origin.y, _woodUp1.frame.size.width, _woodUp1.frame.size.height);
    _woodUp2.frame = CGRectMake(_woodUp2.frame.origin.x-1, _woodUp2.frame.origin.y, _woodUp2.frame.size.width, _woodUp2.frame.size.height);
    _woodDown1.frame = CGRectMake(_woodDown1.frame.origin.x-1, _woodDown1.frame.origin.y, _woodDown1.frame.size.width, _woodDown1.frame.size.height);
    _woodDown2.frame = CGRectMake(_woodDown2.frame.origin.x-1, _woodDown2.frame.origin.y, _woodDown2.frame.size.width, _woodDown2.frame.size.height);
    if (_woodUp1.frame.origin.x+_woodUp1.frame.size.width <= 0) {
        float sH = viewHeight;
        int parm = sH-woodMinHeight-crossHeight-woodMinHeight;
        int height = arc4random()%parm+150;
        _woodUp1.frame = CGRectMake(_woodUp2.frame.origin.x+350, 0, _woodUp2.frame.size.width, height);
        _woodDown1.frame = CGRectMake(_woodUp2.frame.origin.x+350, height+crossHeight, _woodUp2.frame.size.width, viewHeight-(height+crossHeight));
    }
    if(_woodUp2.frame.origin.x+_woodUp2.frame.size.width <= 0) {
        float sH = viewHeight;
        int parm = sH-woodMinHeight-crossHeight-woodMinHeight;
        int height = arc4random()%parm+150;
        _woodUp2.frame = CGRectMake(_woodUp1.frame.origin.x+350, 0, _woodUp1.frame.size.width, height);
        _woodDown2.frame = CGRectMake(_woodDown1.frame.origin.x+350, height+crossHeight, _woodUp1.frame.size.width, viewHeight-(height+crossHeight));
    }
    _sourceLabel.text = [NSString stringWithFormat:@"当前:%d",_source];
    if(_mBird.frame.origin.x == (_woodUp1.frame.origin.x+_woodUp1.frame.size.width)||
       _mBird.frame.origin.x == (_woodUp2.frame.origin.x+_woodUp2.frame.size.width)) {
        _source+=1;
        _sourceLabel.text = [NSString stringWithFormat:@"当前:%d",_source];
    }
    [self ifDead];
}

- (void)ifDead {
    if (_mBird.frame.origin.y+_mBird.frame.size.height > _floor1.frame.origin.y) {
        [self gameOver];
    }
    
    if(CGRectIntersectsRect(_mBird.frame, _woodUp1.frame) ||
       CGRectIntersectsRect(_mBird.frame, _woodUp2.frame) ||
       CGRectIntersectsRect(_mBird.frame, _woodDown1.frame) ||
       CGRectIntersectsRect(_mBird.frame, _woodDown2.frame)) {
        [self gameOver];
    }
}

- (void)gameOver {
    [_mBird stopFlying];
    [_mBird stopLand];
    _timer.fireDate = [NSDate distantFuture];
    [_overView setSource:_source];
    [_overView show];
    _sourceLabel.hidden = YES;
    _source = 0;
}


#pragma mark delegate
- (void)gameOverViewUnShow {
    [_startView show];
    _mBird.center = CGPointMake(100, 300);
    [_mBird startFlying];
    [self makeWoodFrame];
}

- (void)gameStartTouchStart {
    [_startView unShow];
    _timer.fireDate = [NSDate distantPast];
    _sourceLabel.hidden = NO;
    [_mBird startLand];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_mBird upFly];
}

@end

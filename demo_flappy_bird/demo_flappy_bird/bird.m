//
//  bird.m
//  demo_flappy_bird
//
//  Created by 宋君平 on 2021/10/3.
//

#import "bird.h"

@interface bird()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL coudLand;
@property (nonatomic, assign) CGFloat speed;

@end

@implementation bird

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(10, 10, 40, 31);
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        self.image = [UIImage imageNamed:@"player1"];
        NSMutableArray *array = @[].mutableCopy;
        for (int i = 0; i < 3; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"player%d",i+1]];
            [array addObject:image];
        }
        self.animationImages = array;
        self.animationDuration = 1;
        self.animationRepeatCount = 0;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1/60.0 target:self selector:@selector(updateBird) userInfo:nil repeats:YES];
        _speed = 0;
        _coudLand = NO;
    }
    return self;
}

- (void)startFlying {
    if (self.isAnimating) {
        return;
    }
    [self startAnimating];
}

- (void)stopFlying {
    if(self.isAnimating) {
        [self stopAnimating];
    }
}

- (void)startLand {
    _coudLand = YES;
}

- (void)stopLand {
    _coudLand = NO;
}

- (void)upFly {
    _speed = -2.5;
}

- (void)updateBird {
    if(_coudLand) {
        self.center = CGPointMake(self.center.x, self.center.y+self.speed);
        self.speed += G/60.0;
        if (self.center.y <= 0) {
            self.center = CGPointMake(self.center.x, 0);
        } else if (self.center.y + self.frame.size.height/2>=self.superview.frame.size.height) {
            self.center = CGPointMake(self.center.x, self.superview.frame.size.height-self.frame.size.height/2);
        }
    } else {
        _speed = 0;
    }
}

@end

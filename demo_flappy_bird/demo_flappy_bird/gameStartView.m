//
//  gameStartView.m
//  demo_flappy_bird
//
//  Created by 宋君平 on 2021/10/3.
//

#import "gameStartView.h"

@interface gameStartView()
@end

@implementation gameStartView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIImageView *bg = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width/2 -128, 350, 256, 72)];
        bg.backgroundColor = [UIColor clearColor];
        [self addSubview:bg];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(self.frame.size.width/2-67, 325, 135, 75);
        [btn setTitle:@"开始游戏!" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:23];
        [btn addTarget:self action:@selector(touched) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    return self;
}

- (void)touched {
    [self unShow];
    if([self.delegate respondsToSelector:@selector(gameStartTouchStart)]) {
        [self.delegate gameStartTouchStart];
    }
}

- (void)show {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
    }];
}

- (void)unShow {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }];
}
@end

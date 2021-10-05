//
//  gameOverView.m
//  demo_flappy_bird
//
//  Created by 宋君平 on 2021/10/3.
//

#import "gameOverView.h"

@interface gameOverView()
@property(nonatomic, strong) UILabel *label;

@end

@implementation gameOverView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _label = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2-100, 200, 200, 50)];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont boldSystemFontOfSize:23];
        _label.textColor = [UIColor blackColor];
        [self addSubview:_label];
        self.alpha = 0;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self unShow];
    if ([self.delegate respondsToSelector:@selector(gameOverViewUnShow)]) {
        [self.delegate gameOverViewUnShow];
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

- (void)setSource:(int)source {
    _label.text = [NSString stringWithFormat:@"总分:%d",source];
}

@end

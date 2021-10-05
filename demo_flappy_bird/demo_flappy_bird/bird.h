//
//  bird.h
//  demo_flappy_bird
//
//  Created by 宋君平 on 2021/10/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define G 4

@interface bird : UIImageView
/// 飞行
- (void) startFlying;
- (void) stopFlying;
/// 下落
- (void) startLand;
- (void) stopLand;
/// 向上飞
- (void) upFly;
@end

NS_ASSUME_NONNULL_END

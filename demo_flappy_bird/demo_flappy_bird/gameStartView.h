//
//  gameStartView.h
//  demo_flappy_bird
//
//  Created by 宋君平 on 2021/10/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol GameStartViewDelegate <NSObject>
- (void)gameStartTouchStart;

@end

@interface gameStartView : UIView
@property(nonatomic, weak) id<GameStartViewDelegate> delegate;

- (void)show;
- (void)unShow;
@end

NS_ASSUME_NONNULL_END

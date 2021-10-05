//
//  gameOverView.h
//  demo_flappy_bird
//
//  Created by 宋君平 on 2021/10/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GameOverViewDelegate <NSObject>
- (void)gameOverViewUnShow;

@end

@interface gameOverView : UIView
@property (nonatomic, weak)id<GameOverViewDelegate> delegate;
- (void)show;
- (void)unShow;
- (void)setSource:(int)source;

@end

NS_ASSUME_NONNULL_END

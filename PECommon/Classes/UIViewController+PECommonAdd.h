//
//  UIViewController+PECommonAdd.h
//  PECommon
//
//  Created by sky on 2020/11/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 获取keyWindos
#define PEKeyWindow [UIViewController getKeyWindow]

@interface UIViewController (PECommonAdd)

/// 获取keyWindos
+ (UIWindow *)getKeyWindow;

/**
 获取当前最顶层的NavigationController

 @return UINavigationController
 */
+ (UINavigationController *)currentNavigationController;

/**
 获取当前最顶层的NavigationController的最顶层的viewcontroller

 @return UIViewController
 */
+ (UIViewController *)currentTopViewController;

/**
 * present充满屏幕的vc
 */
- (void)presentFulleViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^ __nullable)(void))completion;
@end

NS_ASSUME_NONNULL_END

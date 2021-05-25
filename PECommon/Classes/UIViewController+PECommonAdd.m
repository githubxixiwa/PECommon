//
//  UIViewController+PECommonAdd.m
//  PECommon
//
//  Created by sky on 2020/11/10.
//

#import "UIViewController+PECommonAdd.h"

@implementation UIViewController (PECommonAdd)
/// 获取keyWindos
+ (UIWindow *)getKeyWindow {
    UIWindow *window = nil;
    if (@available(iOS 13.0, *)) {
        for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                for (UIWindow *currentWindow in windowScene.windows) {
                    if (currentWindow.isKeyWindow) {
                        window = currentWindow;
                        break;
                    }
                }
            }
        }
        if (!window) {
            window =  [UIApplication sharedApplication].keyWindow;
        }
    } else {
        window =  [UIApplication sharedApplication].keyWindow;
    }
    return window;
}

#pragma mark - 获取当前最顶层的UINavigationController
+ (UINavigationController *)currentNavigationController {
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    if (!rootViewController) {
        return nil;
    }

    while (rootViewController.presentedViewController) {
        rootViewController = rootViewController.presentedViewController;
    }

    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UINavigationController *navigationController = ((UITabBarController *)rootViewController).selectedViewController;
        while (navigationController.presentedViewController && [navigationController.presentedViewController isKindOfClass:UINavigationController.class]) {
            navigationController = (UINavigationController *)navigationController.presentedViewController;
        }
        return navigationController;
    }

    if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController;
        while (navigationController.presentedViewController && [navigationController.presentedViewController isKindOfClass:UINavigationController.class]) {
            navigationController = (UINavigationController *)navigationController.presentedViewController;
        }
        return navigationController;
    }

    return nil;
}

#pragma mark - 获取当前最顶层的UINavigationController的最顶层的viewcontroller
+ (UIViewController *)currentTopViewController {
    UIViewController *topViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    if ([topViewController isKindOfClass:UITabBarController.class]) {
        
    } else {
        if ([topViewController isKindOfClass:[UINavigationController class]]) {
            if (topViewController.presentedViewController) {
                
            } else {
                topViewController = ((UINavigationController *)topViewController).topViewController;
            }
        }
    }
    while (topViewController.presentedViewController) {
        topViewController = topViewController.presentedViewController;
        if ([topViewController isKindOfClass:[UINavigationController class]]) {
            if (topViewController.presentedViewController) {
                
            } else {
                topViewController = ((UINavigationController *)topViewController).topViewController;
            }
        }
    }
    return topViewController;
}

/**
 * present充满屏幕的vc
 */
- (void)presentFulleViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^ __nullable)(void))completion {
    viewControllerToPresent.modalPresentationStyle = UIModalPresentationOverCurrentContext | UIModalPresentationFullScreen;
    [self presentViewController:viewControllerToPresent animated:flag completion:completion];
}
@end

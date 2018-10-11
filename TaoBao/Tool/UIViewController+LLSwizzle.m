//
//  UIViewController+LLSwizzle.m
//  MyProjectTest
//
//  Created by lyonse on 16/12/16.
//  Copyright © 2016年 lyonse. All rights reserved.
//

#import "UIViewController+LLSwizzle.h"
#import <objc/runtime.h>

@implementation UIViewController (LLSwizzle)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self changeMethodImpOrigin:@selector(initWithNibName:bundle:) ImpSwizzle:@selector(initWithNibNameNew:bundle:)];
        [self changeMethodImpOrigin:sel_getUid("dealloc") ImpSwizzle:@selector(deallocNew)];
    });
}

+ (void)changeMethodImpOrigin:(SEL)impOrigin ImpSwizzle:(SEL)impSwizzle {
    Class class = [self class];
    
    SEL originalSelector = impOrigin;
    SEL swizzledSelector = impSwizzle;
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


- (instancetype)initWithNibNameNew:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    NSLog(@"init: ------ %@", NSStringFromClass([self class]));
    return [self initWithNibNameNew:nibNameOrNil bundle:nibBundleOrNil];
}

- (void)viewDidLoadNew {
    NSLog(@"viewDidLoad: ------ %@", NSStringFromClass([self class]));
    [self viewDidLoadNew];
}

- (void)viewWillAppearNew:(BOOL)animated {
    NSLog(@"viewWillAppear: ------ %@", NSStringFromClass([self class]));
    [self viewWillAppearNew:animated];
}

- (void)viewWillDisappearNew:(BOOL)animated {
    NSLog(@"viewWillDisappear: ------ %@", NSStringFromClass([self class]));
    [self viewWillDisappearNew:animated];
}

- (void)deallocNew {
    NSLog(@"dealloc: ------ %@", NSStringFromClass([self class]));
    [self deallocNew];
}
@end

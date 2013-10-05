//
//  MTMultipleViewController.h
//
//  Created by Mat Trudel on 2013-01-23.
//  Copyright (c) 2013 Mat Trudel. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MTMultipleViewControllerDelegate;

@interface MTMultipleViewController : UIViewController
@property(nonatomic) NSUInteger selectedIndex;
@property(nonatomic) NSArray *viewControllers;
@property(nonatomic,weak) id<MTMultipleViewControllerDelegate> delegate;
@property(nonatomic, weak) IBOutlet UISegmentedControl *segmentedControl;
@property(nonatomic, weak) IBOutlet UIView *childViewArea;

@property(nonatomic) BOOL lockedTitle;
@property(nonatomic) BOOL lockedPrompt;
@property(nonatomic) BOOL lockedBackBarButtonItem;
@property(nonatomic) BOOL lockedHidesBackButton;
@property(nonatomic) BOOL lockedLeftItemsSupplementBackButton;
@property(nonatomic) BOOL lockedLeftBarButtonItems;
@property(nonatomic) BOOL lockedLeftBarButtonItem;
@property(nonatomic) BOOL lockedRightBarButtonItems;
@property(nonatomic) BOOL lockedRightBarButtonItem;

@end

@protocol MTMultipleViewControllerDelegate <NSObject>

@optional

- (void)multipleViewController:(MTMultipleViewController *)controller didChangeSelectedViewControllerIndex:(NSUInteger)newIndex;

@end
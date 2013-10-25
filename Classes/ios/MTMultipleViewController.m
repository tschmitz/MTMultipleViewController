//
//  MTMultipleViewController.m
//
//  Created by Mat Trudel on 2013-01-23.
//  Copyright (c) 2013 Mat Trudel. All rights reserved.
//

#import "MTMultipleViewController.h"

@interface MTMultipleViewController ()
@end

@implementation MTMultipleViewController


#pragma mark - Initializers

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    [self setupInitialState];
  }
  return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super initWithCoder:aDecoder]) {
    [self setupInitialState];
  }
  return self;
}

- (void)setupInitialState {
	_viewControllers = [NSMutableArray array];
	if(!_segmentedControl) {
		_segmentedControl = [[UISegmentedControl alloc] initWithFrame:CGRectMake(0, 0, 300, 29)];
		[_segmentedControl addTarget:self action:@selector(selectedButtonChanged:) forControlEvents:UIControlEventValueChanged];
	}
	[self setupSegmentedControl];
}

- (void)setupSegmentedControl {
	[self.segmentedControl removeAllSegments];
	for(UIViewController *controller in self.viewControllers) {
		[self.segmentedControl insertSegmentWithTitle:controller.navigationItem.title atIndex:[self.viewControllers indexOfObject:controller] animated:NO];
	}
}

#pragma mark - View lifecycle


- (void)viewDidLoad {
	if(self.viewControllers.count) {
	  [self makeViewControllerVisible:self.viewControllers[self.selectedIndex]];
	}
}

- (void)viewDidUnload {
	if(self.viewControllers.count) {
	  [self makeViewControllerInvisible:self.viewControllers[self.selectedIndex]];
	}
}


#pragma mark - Public access methods

- (void)setViewControllers:(NSArray *)viewControllers {
	_viewControllers = viewControllers;
	[self setupSegmentedControl];
	self.selectedIndex = 0;
	if(viewControllers.count) {
		self.segmentedControl.selectedSegmentIndex = 0;
		[self makeViewControllerVisible:self.viewControllers[self.selectedIndex]];
	}
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
  if (selectedIndex != _selectedIndex) {
    [self makeViewControllerVisible:self.viewControllers[selectedIndex]];
    [self makeViewControllerInvisible:self.viewControllers[_selectedIndex]];

    _selectedIndex = selectedIndex;

    self.segmentedControl.selectedSegmentIndex = selectedIndex;

    if ([self.delegate respondsToSelector:@selector(multipleViewController:didChangeSelectedViewControllerIndex:)]) {
      [self.delegate multipleViewController:self didChangeSelectedViewControllerIndex:selectedIndex];
    }
  }
}


#pragma mark - Internal methods


- (IBAction)selectedButtonChanged:(id)sender {
  self.selectedIndex = [sender selectedSegmentIndex];
}


- (void)makeViewControllerVisible:(UIViewController *)newController {
  if (!self.lockedTitle) {
    self.navigationItem.title = newController.navigationItem.title;
  }
  if (!self.lockedPrompt) {
    self.navigationItem.prompt = newController.navigationItem.prompt;
  }
  if (!self.lockedBackBarButtonItem) {
    self.navigationItem.backBarButtonItem = newController.navigationItem.backBarButtonItem;
  }
  if (!self.lockedHidesBackButton) {
    self.navigationItem.hidesBackButton = newController.navigationItem.hidesBackButton;
  }
  if (!self.lockedLeftItemsSupplementBackButton) {
    self.navigationItem.leftItemsSupplementBackButton = newController.navigationItem.leftItemsSupplementBackButton;
  }
  if (!self.lockedLeftBarButtonItems && newController.navigationItem.leftBarButtonItems) {
    self.navigationItem.leftBarButtonItems = newController.navigationItem.leftBarButtonItems;
  }
  if (!self.lockedLeftBarButtonItem) {
    self.navigationItem.leftBarButtonItem = newController.navigationItem.leftBarButtonItem;
  }
  if (!self.lockedRightBarButtonItems && newController.navigationItem.rightBarButtonItems) {
    self.navigationItem.rightBarButtonItems = newController.navigationItem.rightBarButtonItems;
  }
  if (!self.lockedRightBarButtonItem) {
    self.navigationItem.rightBarButtonItem = newController.navigationItem.rightBarButtonItem;
  }
	
	UIView *targetView;
	if(self.childViewArea) {
		targetView = self.childViewArea;
	} else {
		targetView = self.view;
	}
	
  newController.view.frame = targetView.bounds;
  [newController beginAppearanceTransition:YES animated:NO];
  [targetView addSubview:newController.view];
  [newController endAppearanceTransition];
}


- (void)makeViewControllerInvisible:(UIViewController *)oldController {
  [oldController beginAppearanceTransition:NO animated:NO];
  [oldController.view removeFromSuperview];
  [oldController endAppearanceTransition];
}

@end
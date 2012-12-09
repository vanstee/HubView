//
//  DetailViewController.h
//  HubView
//
//  Created by Patrick Van Stee on 12/9/12.
//  Copyright (c) 2012 Patrick Van Stee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end

//
//  MasterViewController.h
//  HubView
//
//  Created by Patrick Van Stee on 12/9/12.
//  Copyright (c) 2012 Patrick Van Stee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end

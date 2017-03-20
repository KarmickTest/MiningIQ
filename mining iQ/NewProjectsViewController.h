//
//  NewProjectsViewController.h
//  mining iQ
//
//  Created by Anirban on 06/02/17.
//  Copyright © 2017 Anirban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewProjectsTableViewCell.h"

@interface NewProjectsViewController : UIViewController
{
    NewProjectsTableViewCell *cell;
    
    NSMutableArray*arr_ProjectDetails;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

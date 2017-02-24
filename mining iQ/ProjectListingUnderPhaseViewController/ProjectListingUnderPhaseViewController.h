//
//  ProjectListingUnderPhaseViewController.h
//  mining iQ
//
//  Created by Somnath on 23/02/17.
//  Copyright © 2017 Anirban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectListingUnderPhaseTableViewCell.h"

@interface ProjectListingUnderPhaseViewController : UIViewController
{
    ProjectListingUnderPhaseTableViewCell *cell;
}

@property (weak, nonatomic) IBOutlet UITableView *subProjectsTableView;
@property (strong, nonatomic)NSString *phaseId;
@end

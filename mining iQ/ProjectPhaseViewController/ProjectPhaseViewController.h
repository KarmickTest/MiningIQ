//
//  ProjectPhaseViewController.h
//  mining iQ
//
//  Created by Admin on 10/02/17.
//  Copyright © 2017 Anirban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectPhaseCell.h"


@interface ProjectPhaseViewController : UIViewController
{
    ProjectPhaseCell *cell;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)btnBack:(id)sender;


@end

//
//  ProjectDetailViewController.h
//  mining iQ
//
//  Created by Somnath on 10/02/17.
//  Copyright © 2017 Anirban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectDetailTableViewCell.h"

@interface ProjectDetailViewController : UIViewController
{
    ProjectDetailTableViewCell *cell;
}

@property (weak, nonatomic) IBOutlet UILabel *projectDescriptionLbl;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *headerSubView;

@end

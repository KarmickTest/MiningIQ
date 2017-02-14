//
//  NewProjectsTableViewCell.h
//  mining iQ
//
//  Created by Anirban on 06/02/17.
//  Copyright © 2017 Anirban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewProjectsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *cellBackView;
@property (weak, nonatomic) IBOutlet UILabel *projectNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *projectDateLbl;

@end

//
//  ProjectofInterestCell.h
//  mining iQ
//
//  Created by Karmick on 10/02/17.
//  Copyright © 2017 Anirban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectofInterestCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *demoProjectLbl;

@property (strong, nonatomic) IBOutlet UIButton *btnDelete;
@property (strong, nonatomic) IBOutlet UIButton *btnProjectDetails;



@end

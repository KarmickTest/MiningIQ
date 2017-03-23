//
//  ProjectDetailTableViewCell.h
//  mining iQ
//
//  Created by Somnath on 10/02/17.
//  Copyright © 2017 Anirban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;

@property (strong, nonatomic) IBOutlet UILabel *lbl_scope_date;
@property (strong, nonatomic) IBOutlet UILabel *lbl_scope_description;
@property (strong, nonatomic) IBOutlet UILabel *lbl_scope_Continent;
@property (strong, nonatomic) IBOutlet UILabel *lbl_scope_Region;
@property (strong, nonatomic) IBOutlet UILabel *lbl_scope_country;
@property (strong, nonatomic) IBOutlet UILabel *lbl_scope_Province;
@property (strong, nonatomic) IBOutlet UILabel *lbl_scope_City;
@property (strong, nonatomic) IBOutlet UILabel *lbl_scope_Projectarea;
@property (strong, nonatomic) IBOutlet UILabel *lbl_scope_NearestTown;
@property (strong, nonatomic) IBOutlet UILabel *lbl_scope_CapitalValue;
@property (strong, nonatomic) IBOutlet UILabel *lbl_scope_ExplorationValue;
@property (strong, nonatomic) IBOutlet UILabel *lbl_scope_Mineral;
@property (strong, nonatomic) IBOutlet UILabel *lbl_scope_BiMineralPlant;
@property (strong, nonatomic) IBOutlet UILabel *lbl_scope_MiningType;
@property (strong, nonatomic) IBOutlet UILabel *lbl_scope_projectName;




@end

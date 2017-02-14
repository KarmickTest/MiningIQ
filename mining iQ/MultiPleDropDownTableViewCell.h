//
//  MultiPleDropDownTableViewCell.h
//  mining iQ
//
//  Created by Somnath on 08/02/17.
//  Copyright © 2017 Anirban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MultiPleDropDownTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *headingNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;
@property (weak, nonatomic) IBOutlet UILabel *subContentLbl;
@property (weak, nonatomic) IBOutlet UIView *containerView1;
@property (weak, nonatomic) IBOutlet UIView *containerView2;
@end

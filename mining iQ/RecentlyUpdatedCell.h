//
//  RecentlyUpdatedCell.h
//  mining iQ
//
//  Created by Admin on 10/02/17.
//  Copyright © 2017 Anirban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecentlyUpdatedCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *cellBackView;
@property (weak, nonatomic) IBOutlet UILabel *projectNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *dateLbl;

@end

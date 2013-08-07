//
//  AverageCell.h
//  MyPsych
//
//  Created by James Lockwood on 6/5/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AverageCell : UITableViewCell

@property (strong) IBOutlet UIView* barView;
@property (strong) IBOutlet UILabel* nameLabel;
@property (strong) IBOutlet UILabel* averageLabel;

@end
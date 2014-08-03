//
//  DescriptionItemViewController.h
//  categoriesTreeMeli
//
//  Created by usuario on 02/08/14.
//  Copyright (c) 2014 usuario. All rights reserved.
//

#import "ViewController.h"

@interface DescriptionItemViewController : ViewController

@property (weak, nonatomic) IBOutlet UILabel *lblDescription;


@property (strong, nonatomic) NSString *idSelected;

- (NSString*) getDescriptionId:(NSString *)idArticulo;

@end

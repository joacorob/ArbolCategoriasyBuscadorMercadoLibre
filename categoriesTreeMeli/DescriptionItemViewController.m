//
//  DescriptionItemViewController.m
//  categoriesTreeMeli
//
//  Created by usuario on 02/08/14.
//  Copyright (c) 2014 usuario. All rights reserved.
//

#import "DescriptionItemViewController.h"

@interface DescriptionItemViewController ()

@end

@implementation DescriptionItemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *description = [self getDescriptionId:self.idSelected];
    self.lblDescription.text = description;
}

- (NSString*) getDescriptionId:(NSString *)idArticulo {
    //busco los datos
    NSString *url = [NSString stringWithFormat:@"https://api.mercadolibre.com/items/%@/description/", idArticulo];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    //los dejo en un data
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    
    //armo el diccionario
    NSError *jsonParsingError = nil;
    NSDictionary *datos = [NSJSONSerialization JSONObjectWithData:response options:0 error:&jsonParsingError];
    
    NSString *toReturn = [datos objectForKey:@"text"];
    
    return toReturn;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

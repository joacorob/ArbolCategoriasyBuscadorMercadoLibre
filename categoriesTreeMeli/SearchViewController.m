//
//  SearchViewController.m
//  categoriesTreeMeli
//
//  Created by usuario on 02/08/14.
//  Copyright (c) 2014 usuario. All rights reserved.
//

#import "SearchViewController.h"
#import "ItemViewController.h"


@interface SearchViewController (){
    NSMutableArray *results;
}

@end

@implementation SearchViewController

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
}


- (IBAction)getSearch:(id)sender {
    [self.textField resignFirstResponder];
    if ([self.textField.text length] != 0) {
        // creo un string, le doy el valor del textField y adapto el string a buscar
        NSString *nueva = self.textField.text;
        
        NSString *url = [NSString stringWithFormat:@"https://api.mercadolibre.com/sites/MLU/search?q=%@", nueva];
        
        
        //busco los datos
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        //los dejo en un data
        NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        
        //armo el diccionario
        NSError *jsonParsingError = nil;
        NSDictionary *datos = [NSJSONSerialization JSONObjectWithData:response options:0 error:&jsonParsingError];
        
        
        // me quedo solo con los resultados
        results = [datos objectForKey:@"results"];
        ItemViewController *story;
        //ItemViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"goToList"];
        [self prepareForSegue:story.storyboard sender:@"goToList"];
        //        ItemViewController *aPasar;
        //        aPasar.idToShow = idResults;
        [self.navigationController pushViewController:self.presentedViewController animated:YES];
        
        //[self performSegueWithIdentifier:@"goToList" sender:self];
        
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
        ItemViewController *itemList = [segue destinationViewController];
        itemList.idToShow = results;
        
    
}



@end

//
//  ChildCategoriesViewController.m
//  categoriesTreeMeli
//
//  Created by usuario on 31/07/14.
//  Copyright (c) 2014 usuario. All rights reserved.
//

#import "ChildCategoriesViewController.h"
#import "ItemViewController.h"

@interface ChildCategoriesViewController ()
{
    NSMutableArray *childCategories;
    NSMutableArray *idResults;
}
@end

@implementation ChildCategoriesViewController

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
    childCategories = [[NSMutableArray alloc] init];
    idResults = [[NSMutableArray alloc] init];
    [self getChildCategories];
    
}

-(void) getChildCategories {
    
    [idResults removeAllObjects];
    [childCategories removeAllObjects];
    NSString *url = [NSString stringWithFormat:@"https://api.mercadolibre.com/categories/%@", self.categoria];
    
    
    //busco los datos
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    //los dejo en un data
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    
    //armo el array
    NSError *jsonParsingError = nil;
    NSMutableDictionary *datostotales = [NSJSONSerialization JSONObjectWithData:response options:0 error:&jsonParsingError];
    
    NSMutableArray *datos = [datostotales objectForKey:@"children_categories"];
    
    //si no tiene hijos, entonces armo array para pasar a otra vista.
    if ([datos count] == 0) {
        NSString *secondUrl = [NSString stringWithFormat:@"https://api.mercadolibre.com/sites/MLU/search?category=%@", self.categoria];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[secondUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        //los dejo en un data
        NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        
        //armo el array
        NSError *jsonParsingError = nil;
        NSMutableDictionary *totalResults = [NSJSONSerialization JSONObjectWithData:response options:0 error:&jsonParsingError];
        
        NSMutableArray *results = [totalResults objectForKey:@"results"];
        
        for (NSInteger i=0; i<[results count]; i++) {
            NSDictionary *resultadoEspecifico = [results objectAtIndex:i];
            [idResults addObject:resultadoEspecifico];
        }
        
        ItemViewController *story;
        [self prepareForSegue:story.storyboard sender:@"goToDestination"];
//        ItemViewController *aPasar;
//        aPasar.idToShow = idResults;
        [self performSegueWithIdentifier:@"goToDestination" sender:self];
        

    } else {
        for (NSUInteger i=0; i<[datos count]; i++) {
            NSDictionary *elemento = [datos objectAtIndex:i];
            [childCategories insertObject:elemento atIndex:i];
            [self.tableView reloadData];
        }
    }
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return @"Ver todas";
    }
    else
    {
        return @"SubCategorias";
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    if(section == 0)
    {
        return 1;
    }
    else if(section == 1)
    {
        return [childCategories count];
    }
    else
    {
        return 3;
    }
    
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"Ver Todas";
    }
    else {
        
    
    // Configure the cell...
    NSString *celda = [NSString stringWithFormat:@"%@(%@)", [[childCategories objectAtIndex:indexPath.row] objectForKey:@"name"], [[[childCategories objectAtIndex:indexPath.row] objectForKey:@"total_items_in_this_category"] stringValue]];
    cell.textLabel.text = celda ;
    
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        NSString *secondUrl = [NSString stringWithFormat:@"https://api.mercadolibre.com/sites/MLU/search?category=%@", self.categoria];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[secondUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        //los dejo en un data
        NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        
        //armo el array
        NSError *jsonParsingError = nil;
        NSMutableDictionary *totalResults = [NSJSONSerialization JSONObjectWithData:response options:0 error:&jsonParsingError];
        
        NSMutableArray *results = [totalResults objectForKey:@"results"];
        
        for (NSInteger i=0; i<[results count]; i++) {
            NSDictionary *resultadoEspecifico = [results objectAtIndex:i];
            [idResults addObject:resultadoEspecifico];
        }
        
        ItemViewController *story;
        [self prepareForSegue:story.storyboard sender:@"goToDestination"];
        //        ItemViewController *aPasar;
        //        aPasar.idToShow = idResults;
        [self performSegueWithIdentifier:@"goToDestination" sender:self];

    }
    else {
        self.categoria = [[childCategories objectAtIndex:indexPath.row] objectForKey:@"id"];
        [self getChildCategories];
        [tableView reloadData];
    }

}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"goToDestination"]) {
        ItemViewController *aPasar =[segue destinationViewController];
        aPasar.idToShow = idResults;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end

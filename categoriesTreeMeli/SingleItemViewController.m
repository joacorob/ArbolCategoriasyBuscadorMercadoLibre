//
//  SingleItemViewController.m
//  categoriesTreeMeli
//
//  Created by usuario on 02/08/14.
//  Copyright (c) 2014 usuario. All rights reserved.
//

#import "SingleItemViewController.h"
#import "DescriptionItemViewController.h"

@interface SingleItemViewController () {
    NSMutableArray *imagesArray;
}

@end

@implementation SingleItemViewController

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
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 618)];
    self.lblid.text = [self.itemSelected objectForKey:@"id"];
    self.lblTitle.text = [self.itemSelected objectForKey:@"title"];
    self.lblBuyingMode.text = [self.itemSelected objectForKey:@"buying_mode"];
    
    NSString *moneda = [self.itemSelected objectForKey:@"currency_id"];
    if ([moneda isKindOfClass:[NSNull class]]) {
        self.lblPrice.hidden = YES;
        self.lblCondition.hidden = YES;
        self.lblCurrency.text = @"Precio a Convenir";
    }
    else
    {
        self.lblCurrency.text = [self.itemSelected objectForKey:@"currency_id"];
        self.lblPrice.text = [[self.itemSelected objectForKey:@"price"] stringValue];
        self.lblCondition.text = [self.itemSelected objectForKey:@"condition"];
        
    }
    imagesArray = [NSMutableArray array];
    [self getImages];
}

-(void) getImages {
    // fijo el articulo al que voy a ir a buscar las imagenes
    NSString *articuloSeleccionado = [self.itemSelected objectForKey:@"id"];
    //nueva = [nueva stringByReplacingOccurrencesOfString:@" " withString:@"\uFF0520"];
    
    //preparo la url a la que voy a buscar el query
    NSString *url = @"https://api.mercadolibre.com/items?ids=";
    url = [url stringByAppendingString:articuloSeleccionado];
    url = [url stringByAppendingString:@"&attributes=pictures"];
    
    //busco los datos
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    //los dejo en un data
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    
    //armo el diccionario
    NSError *jsonParsingError = nil;
    NSArray *datos = [NSJSONSerialization JSONObjectWithData:response options:0 error:&jsonParsingError];
    
    //NSLog(datos);
    
    NSArray *diccionario = [[datos objectAtIndex:0] objectForKey:@"pictures"];
    
    for (NSUInteger i= 0; i < [diccionario count]; i++) {
        NSDictionary *elemento = [diccionario objectAtIndex:i];
        [imagesArray addObject:[elemento objectForKey:@"url"]];
    }
    
    NSString *urlImagen = [imagesArray objectAtIndex:0];
    
    
    if (urlImagen) {
        NSURL *url = [NSURL URLWithString:urlImagen];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [[UIImage alloc] initWithData:data];
        self.imagesView.image = img;
//        self.imageView.image = img;
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
    
    DescriptionItemViewController *description = [segue destinationViewController];
    description.idSelected = self.lblid.text;
}


@end

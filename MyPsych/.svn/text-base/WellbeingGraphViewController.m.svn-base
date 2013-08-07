//
//  WellbeingGraphViewController.m
//  MyPsych
//
//  Created by James Lockwood on 5/11/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import "WellbeingGraphViewController.h"
#import "WellbeingDataEntry.h"
#import "ProfileDataManager.h"
#import "AverageTableViewController.h"
#import "GraphTabViewController.h"

@interface WellbeingGraphViewController ()
@property (strong) CPTXYGraph* thisGraph;
@property (strong) NSArray* scatterPlots;
@property (strong) CPTPlotSpaceAnnotation *symbolTextAnnotation;

- (void)initializeGraph;

@end

@implementation WellbeingGraphViewController
@synthesize thisGraph = _thisGraph;
@synthesize scatterPlots = _scatterPlots;
@synthesize symbolTextAnnotation = _symbolTextAnnotation;
@synthesize graphContainerView = _graphContainerView;

- (IBAction)legendButtonPressed:(id)sender {
    if ([self.tabBarController isKindOfClass:[GraphTabViewController class]]) {
        [(GraphTabViewController*)self.tabBarController legendButtonPressed:sender];
    }
}

#pragma mark - Bar Plot Data Source

- (CPTFill*)barFillForBarPlot:(CPTBarPlot *)barPlot recordIndex:(NSUInteger)index {
    CPTFill* fill = [CPTFill fillWithGradient:
                     [CPTGradient gradientWithBeginningColor:[[ProfileDataManager sharedManager] colorForIndex:kWellBeingEntryHoursSlept]
                                                 endingColor:[CPTColor darkGrayColor]]];
    return fill;
}

#pragma mark - Scatter Plot Data Source

- (NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot {
    int index = -1;
    for (int i = 0; i < WELLBEING_MINIMUM_COUNT; i++) {
        if ([[plot title] caseInsensitiveCompare:kWellbeingEntryIdentifiers[i]] == NSOrderedSame) {
            index = i;
        }
    }
    BOOL isHidden = [[ProfileDataManager sharedManager] wellBeingGraphHiddenAtIndex:index];
    if (isHidden)
        return 0;
    
    return [[ProfileDataManager sharedManager] wellbeingEntryCount];
}

- (CPTPlotSymbol*)symbolForScatterPlot:(CPTScatterPlot *)plot recordIndex:(NSUInteger)index {
    CPTPlotSymbol* symbol = nil;
    int pindex = -1;
    for (int i = 0; i < WELLBEING_MINIMUM_COUNT; i++) {
        if ([[plot title] caseInsensitiveCompare:kWellbeingEntryIdentifiers[i]] == NSOrderedSame) {
            pindex = i;
        }
    }
    symbol = [[ProfileDataManager sharedManager] symbolForIndex:pindex];
    CPTMutableLineStyle* style = [CPTMutableLineStyle lineStyle];
    style.lineWidth = 0.0f;
    [symbol setLineStyle:style];
    [symbol setFill:[CPTFill fillWithColor:plot.dataLineStyle.lineColor]];
    [symbol setSize:CGSizeMake(14, 14)];
    return symbol;
}

- (NSNumber*)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index {
	WellbeingDataEntry* entry = [[ProfileDataManager sharedManager] wellbeingEntryForIndex:index];
    NSNumber* num = nil;
	if (fieldEnum == CPTScatterPlotFieldX) {
        // X value, date
        // NSDateComponents* todayComps = [ProfileDataManager dateComponentsFromDate:[NSDate date]];
        NSDate* dataDate = [[NSCalendar currentCalendar] dateFromComponents:entry.entryDateComps];
        NSTimeInterval timeApart = [dataDate timeIntervalSinceDate:[NSDate date]];
        NSInteger daysApart = timeApart / kOneDayInSeconds;
        if ([kWellbeingEntryIdentifiers[kWellBeingEntryTomorrow] caseInsensitiveCompare:plot.title] == NSOrderedSame) {
            // is Tomorrow plot
            daysApart += 1;
        }
        if ([kWellbeingEntryIdentifiers[kWellBeingEntryYesterday] caseInsensitiveCompare:plot.title] == NSOrderedSame) {
            // is Tomorrow plot
            daysApart -= 1;
        }
        num = [NSNumber numberWithDouble:daysApart*kOneDayInSeconds];
    } else if (fieldEnum == CPTScatterPlotFieldY) {
        // Y value
        for (int i = 0; i < WELLBEING_MINIMUM_COUNT; i++) {
            NSString* idStr = (NSString*)plot.identifier;
            if ([idStr caseInsensitiveCompare:kWellbeingEntryIdentifiers[i]] == NSOrderedSame) {
                num = [entry numberWithIndex:i];
            }
        }
    }
    
	return num;
}

#pragma mark - CPTPlotSpace delegate

- (CPTPlotRange*)plotSpace:(CPTPlotSpace *)space willChangePlotRangeTo:(CPTPlotRange *)newRange forCoordinate:(CPTCoordinate)coordinate {
    if (coordinate == CPTCoordinateY) {
        newRange = ((CPTXYPlotSpace*)space).yRange;
        return newRange;
    } else {
        NSDecimal newLength = newRange.length;
        double maxLength = kOneDayInSeconds*8.0f;
        double minLength = kOneDayInSeconds*2.0f;
        
        if ([[NSDecimalNumber decimalNumberWithDecimal:newRange.length] doubleValue] >
            [[NSDecimalNumber numberWithDouble:maxLength] doubleValue]) {
            newLength = [[NSDecimalNumber numberWithDouble:maxLength] decimalValue];
        }
        if ([[NSDecimalNumber decimalNumberWithDecimal:newRange.length] doubleValue] <
            [[NSDecimalNumber numberWithDouble:minLength] doubleValue]) {
            newLength = [[NSDecimalNumber numberWithDouble:minLength] decimalValue];
        }
        CPTPlotRange* maxRange = [CPTPlotRange plotRangeWithLocation:newRange.location
                                                              length:newLength];
        return maxRange;
    }
}

- (CGPoint)plotSpace:(CPTPlotSpace *)space willDisplaceBy:(CGPoint)proposedDisplacementVector {
    return CGPointMake(proposedDisplacementVector.x, 0.0f);
}

#pragma mark - CPTScatterPlot delegate

-(void)scatterPlot:(CPTScatterPlot *)plot plotSymbolWasSelectedAtRecordIndex:(NSUInteger)index
{
	CPTXYGraph *graph = self.thisGraph;
    
	if ( self.symbolTextAnnotation ) {
		[graph.plotAreaFrame.plotArea removeAnnotation:self.symbolTextAnnotation];
		self.symbolTextAnnotation = nil;
	}
    
	// Setup a style for the annotation
	CPTMutableTextStyle *hitAnnotationTextStyle = [CPTMutableTextStyle textStyle];
	hitAnnotationTextStyle.color	= [CPTColor blackColor];
	hitAnnotationTextStyle.fontSize = 16.0f;
	hitAnnotationTextStyle.fontName = @"Helvetica-Bold";
    
    
    // Determine point of symbol in plot coordinates
    NSNumber *x			 = [self numberForPlot:plot field:CPTScatterPlotFieldX recordIndex:index];
    NSNumber *y			 = [self numberForPlot:plot field:CPTScatterPlotFieldY recordIndex:index];
    NSArray *anchorPoint = [NSArray arrayWithObjects:x, y, nil];
    
    // Add annotation
    // First make a string for the y value
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:0];
    NSString *yString = [formatter stringFromNumber:y];
    yString = [NSString stringWithFormat:@"%@: %@", [plot title], yString];
    
    // Now add the annotation to the plot area
    CPTTextLayer *textLayer = [[CPTTextLayer alloc] initWithText:yString style:hitAnnotationTextStyle];
    self.symbolTextAnnotation			  = [[CPTPlotSpaceAnnotation alloc] initWithPlotSpace:graph.defaultPlotSpace anchorPlotPoint:anchorPoint];
    self.symbolTextAnnotation.contentLayer = textLayer;
    self.symbolTextAnnotation.displacement = CGPointMake(0.0f, 20.0f);
    
    [graph.plotAreaFrame.plotArea addAnnotation:self.symbolTextAnnotation];
    
}

#pragma mark - View Controller

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.thisGraph reloadData];
}

- (CPTPlotRange*)todaysXRange {
    NSTimeInterval xLow = 0.0f-kOneDayInSeconds;
    return [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(xLow)
                                        length:CPTDecimalFromFloat(kOneDayInSeconds*4.0f)];
}

- (void)moveToTodaysDate {
    CPTXYPlotSpace* plotSpace = (CPTXYPlotSpace*)self.thisGraph.defaultPlotSpace;
    plotSpace.xRange = [self todaysXRange];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.symbolTextAnnotation = nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // [self.graphContainerView setFrame:CGRectInset(self.graphContainerView.frame, 10, 10)];
    [self initializeGraph];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)initializeGraph {
    CGRect frame = [self.graphContainerView frame];
    
    // Initialize the graph
	self.thisGraph = [[CPTXYGraph alloc] initWithFrame:frame];
    [self.thisGraph applyTheme:[CPTTheme themeNamed:kCPTPlainWhiteTheme]];
    [self.graphContainerView setHostedGraph:self.thisGraph];
    
    // self.thisGraph.title = @"Wellbeing Graph";
	CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
	textStyle.color				   = [CPTColor grayColor];
	textStyle.fontName			   = @"Helvetica-Bold";
	textStyle.fontSize			   = round(frame.size.height / (CGFloat)20.0);
	self.thisGraph.titleTextStyle  = textStyle;
	self.thisGraph.titleDisplacement = CGPointMake( 0.0f, round(frame.size.height / (CGFloat)18.0) );
	self.thisGraph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    
    // Padding
    self.thisGraph.paddingBottom = 
    self.thisGraph.paddingLeft = 
    self.thisGraph.paddingRight =
    self.thisGraph.paddingTop = 5.0f;
    
    // plotting style is set to line plots
    CPTMutableLineStyle *lineStyle = [CPTMutableLineStyle lineStyle];
    lineStyle.lineColor = [CPTColor blackColor];
    lineStyle.lineWidth = 2.0f;
    
    NSDateComponents* comps = [ProfileDataManager dateComponentsFromDate:[NSDate date]];
    NSDate *refDate = [[NSCalendar currentCalendar] dateFromComponents:comps];
    NSTimeInterval xLow = 0.0f-kOneDayInSeconds;
    
    // X-axis parameters setting
    CPTXYAxisSet *axisSet = (CPTXYAxisSet*)self.thisGraph.axisSet;
    axisSet.xAxis.majorIntervalLength = CPTDecimalFromFloat(kOneDayInSeconds);
    axisSet.xAxis.minorTicksPerInterval = 0;
    axisSet.xAxis.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0.0"); //added for date, adjust x line
    axisSet.xAxis.majorTickLineStyle = lineStyle;
    axisSet.xAxis.minorTickLineStyle = lineStyle;
    axisSet.xAxis.axisLineStyle = lineStyle;
    axisSet.xAxis.minorTickLength = 5.0f;
    axisSet.xAxis.majorTickLength = 7.0f;
    axisSet.xAxis.labelOffset = 3.0f;
    
    // added for date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM/dd";
    // dateFormatter.dateStyle = kCFDateFormatterShortStyle;
    CPTTimeFormatter *timeFormatter = [[CPTTimeFormatter alloc] initWithDateFormatter:dateFormatter];
    timeFormatter.referenceDate = refDate;
    axisSet.xAxis.labelFormatter = timeFormatter;
    
    // Y-axis parameters setting    
    axisSet.yAxis.majorIntervalLength = CPTDecimalFromString(@"2");
    axisSet.yAxis.minorTicksPerInterval = 0;
    axisSet.yAxis.orthogonalCoordinateDecimal = CPTDecimalFromFloat(kOneDayInSeconds); // added for date, adjusts y line
    axisSet.yAxis.majorTickLineStyle = lineStyle;
    axisSet.yAxis.minorTickLineStyle = lineStyle;
    axisSet.yAxis.axisLineStyle = lineStyle;
    axisSet.yAxis.majorTickLength = 5.0f;
    axisSet.yAxis.labelOffset = 3.0f;
    axisSet.yAxis.axisConstraints = [CPTConstraints constraintWithLowerOffset:25.0f];
    
    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    formatter.maximumFractionDigits = 0;
    axisSet.yAxis.labelFormatter = formatter;
    
    NSMutableArray* plotsArray = [NSMutableArray array];
    
    // Do the bar graph first so it stays behind others
    CPTBarPlot* barPlot = [[CPTBarPlot alloc] init];
    [plotsArray addObject:barPlot];
    [barPlot setDelegate:self];
    [barPlot setDataSource:self];
    [barPlot setIdentifier:kWellbeingEntryIdentifiers[kWellBeingEntryHoursSlept]];
    [barPlot setTitle:kWellbeingEntryIdentifiers[kWellBeingEntryHoursSlept]];
    [barPlot setBarWidth:CPTDecimalFromFloat(kOneDayInSeconds*0.2f)];
    [barPlot setBarCornerRadius:4.0f];
    [self.thisGraph addPlot:barPlot];
    
    // Initialize the scatter plot
    for (int index = 0; index < WELLBEING_MINIMUM_COUNT; index++) {
        if (index != kWellBeingEntryHoursSlept) {
            CPTScatterPlot* scatterPlot = [[CPTScatterPlot alloc] init];
            [plotsArray addObject:scatterPlot];
            [scatterPlot setDelegate:self];
            [scatterPlot setDataSource:self];
            [scatterPlot setIdentifier:kWellbeingEntryIdentifiers[index]];
            [scatterPlot setTitle:kWellbeingEntryIdentifiers[index]];
            
            // Change lines for each plot
            CPTMutableLineStyle *dataLineStyle = [CPTMutableLineStyle lineStyle];
            dataLineStyle.lineWidth = 3.0f;
            dataLineStyle.lineColor = [[ProfileDataManager sharedManager] colorForIndex:index];
            scatterPlot.dataLineStyle = dataLineStyle;
            
            // Add plot to graph
            [self.thisGraph addPlot:scatterPlot];
        }
    }
    self.scatterPlots = [NSArray arrayWithArray:plotsArray];
    
    CPTXYPlotSpace* plotSpace = (CPTXYPlotSpace*)self.thisGraph.defaultPlotSpace;
    plotSpace.allowsUserInteraction = YES;
    plotSpace.delegate = self;
    
    // sets the range of x values
    plotSpace.xRange = [self todaysXRange];
    
    plotSpace.globalXRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(xLow-(kOneDayInSeconds*(GRAPH_DAYS_TOTAL-GRAPH_DAYS_AHEAD)))
                                                          length:CPTDecimalFromFloat(kOneDayInSeconds*GRAPH_DAYS_TOTAL)];
    // sets the range of y values
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(-0.9) 
                                                    length:CPTDecimalFromFloat(11.8)];
    plotSpace.globalYRange = plotSpace.yRange;
}

@end

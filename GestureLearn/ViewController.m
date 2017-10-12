//
//  ViewController.m
//  GestureLearn
//
//  Created by 贺鸿臻 on 2017/10/11.
//  Copyright © 2017年 zhangkong. All rights reserved.
//

#import "ViewController.h"
#import "GestureView.h"
#import "TapGestureRecognizer.h"
#import "DoubleTapGestureRecognizer.h"
#import "TripleTapGestureRecognizer.h"

@interface ViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UISwitch *switcher0;
@property (nonatomic, strong) UISwitch *switcher1;
@end

@implementation ViewController
/**
 属性方法代理详解:http://www.cnblogs.com/wujy/p/5821991.html
 pan swipe(可指定方向) http://www.jianshu.com/p/bc71f4bc8e65
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    TapGestureRecognizer *tap = [[TapGestureRecognizer alloc] initWithTarget:self action:@selector(selector:)];
    tap.delegate = self;
    GestureView *view = [[GestureView alloc] initWithFrame:CGRectMake(100, 100, 200, 400)];
    view.backgroundColor = [UIColor greenColor];
    [view addGestureRecognizer:tap];
    [self.view addSubview:view];
    
    // 分别打开
//    [self learnProperty:tap];
//    [self learnMethod:tap view:view];
//    [self learnSimultaneouslyDelegate:tap view:view];
    [self learnRequireFailureDelegate:tap view:view];
    
}

- (void)learnProperty:(TapGestureRecognizer *)tap {
    // 打开TapGestureRecognizer GestureView ViewController中的 touchesBegan、touchesMoved、touchesEnded、touchesCancelled注释
    /**
     默认为YES，这种情况下当手势识别器识别到触摸之后，会发送touchesCancelled给触摸到的控件以取消控件view对touch的响应，这个时候只有手势识别器响应touch，当设置成NO时，手势识别器识别到触摸之后不会发送touchesCancelled给控件，这个时候手势识别器和控件view均响应touch。
     注意：手势识别和触摸事件是同时存在的，只是因为touchesCancelled导致触摸事件失效
     */
    tap.cancelsTouchesInView = YES;
    
    /**
     默认是NO，这种情况下当发生一个触摸时，手势识别器先捕捉到到触摸，然后发给触摸到的控件，两者各自做出响应。如果设置为YES，手势识别器在识别的过程中（注意是识别过程），不会将触摸发给触摸到的控件，即控件不会有任何触摸事件。只有在识别失败之后才会将触摸事件发给触摸到的控件，这种情况下控件view的响应会延迟约0.15ms。
     */
    tap.delaysTouchesBegan = NO;
    /**
     默认为YES 在手势识别的过程中GestureRecognizer 接收到touchesBegan、touchesMoved、touchesEnded事件是否会传递给nextResponder(其view) YES时不会 NO时会
     若为YES 在手势识别的过程中(例如多次点击的手势,在第一次触摸屏幕后至最后一次点击离开屏幕前) 不调用view的touchesBegan、touchesMoved、touchesEnded等方法 当cancelsTouchesInView == YES 时 当手势失败后view才会调用touchesEnded 当手势识别成功才会调用touchesCancelled
     若为NO   在手势还未在识别过程中 每一次点击(手势还未识别出来) 都会调用view的touchesMoved、touchesEnded
     
     双击手势 快速点击2次:
     
     delaysTouchesEnded == NO
     2017-10-11 18:58:55.819156+0800 GestureLearn[1001:258530] shouldReceiveTouch state = 0
     2017-10-11 18:58:55.820187+0800 GestureLearn[1001:258530] GestureRecognizer touchesBegan
     2017-10-11 18:58:55.820751+0800 GestureLearn[1001:258530] GestureView touchesBegan
     2017-10-11 18:58:55.820935+0800 GestureLearn[1001:258530] ViewController touchesBegan
     2017-10-11 18:58:55.885279+0800 GestureLearn[1001:258530] GestureRecognizer touchesEnded
     2017-10-11 18:58:55.885666+0800 GestureLearn[1001:258530] GestureView touchesEnded
     2017-10-11 18:58:55.885795+0800 GestureLearn[1001:258530] ViewController touchesEnded
     2017-10-11 18:58:55.885861+0800 GestureLearn[1001:258530]
     2017-10-11 18:58:55.955612+0800 GestureLearn[1001:258530] shouldReceiveTouch state = 0
     2017-10-11 18:58:55.956568+0800 GestureLearn[1001:258530] GestureRecognizer touchesBegan
     2017-10-11 18:58:55.957087+0800 GestureLearn[1001:258530] GestureView touchesBegan
     2017-10-11 18:58:55.957213+0800 GestureLearn[1001:258530] ViewController touchesBegan
     2017-10-11 18:58:56.001879+0800 GestureLearn[1001:258530] GestureRecognizer touchesEnded
     2017-10-11 18:58:56.002179+0800 GestureLearn[1001:258530] gestureRecognizerShouldBegin state = 0
     2017-10-11 18:58:56.002369+0800 GestureLearn[1001:258530] TapGesture selector
     2017-10-11 18:58:56.002543+0800 GestureLearn[1001:258530] GestureView touchesCancelled
     2017-10-11 18:58:56.002663+0800 GestureLearn[1001:258530] ViewController touchesCancelled
     2017-10-11 18:58:56.002729+0800 GestureLearn[1001:258530]
     
     delaysTouchesEnded == YES
     2017-10-11 18:57:49.978954+0800 GestureLearn[997:257814] shouldReceiveTouch state = 0
     2017-10-11 18:57:49.979953+0800 GestureLearn[997:257814] GestureRecognizer touchesBegan
     2017-10-11 18:57:49.982075+0800 GestureLearn[997:257814] GestureView touchesBegan
     2017-10-11 18:57:49.982272+0800 GestureLearn[997:257814] ViewController touchesBegan
     2017-10-11 18:57:50.023881+0800 GestureLearn[997:257814] GestureRecognizer touchesEnded
     
     2017-10-11 18:57:50.107825+0800 GestureLearn[997:257814] shouldReceiveTouch state = 0
     2017-10-11 18:57:50.108336+0800 GestureLearn[997:257814] GestureRecognizer touchesBegan
     2017-10-11 18:57:50.140455+0800 GestureLearn[997:257814] GestureRecognizer touchesEnded
     2017-10-11 18:57:50.140889+0800 GestureLearn[997:257814] gestureRecognizerShouldBegin state = 0
     2017-10-11 18:57:50.141081+0800 GestureLearn[997:257814] TapGesture selector
     2017-10-11 18:57:50.141298+0800 GestureLearn[997:257814] GestureView touchesCancelled
     2017-10-11 18:57:50.141429+0800 GestureLearn[997:257814] ViewController touchesCancelled
     
     */
    tap.delaysTouchesEnded = YES;
    tap.numberOfTapsRequired = 2;
}

- (void)learnMethod:(TapGestureRecognizer *)tap view:(GestureView *)view{
    /**
     防止多个手势同时存在导致的逻辑混乱
     如双击手势识别失败才执行单击手势
     */
    DoubleTapGestureRecognizer *doubleTap = [[DoubleTapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapSelector:)];
    [view addGestureRecognizer:doubleTap];
    doubleTap.delegate = self;
    doubleTap.numberOfTapsRequired = 2;
    
    /**
     不加下面这句 双击屏幕
     2017-10-11 19:35:04.286315+0800 GestureLearn[1042:265764] TapGestureRecognizer shouldReceiveTouch state = 0
     2017-10-11 19:35:04.286549+0800 GestureLearn[1042:265764] UITapGestureRecognizer shouldReceiveTouch state = 0
     2017-10-11 19:35:04.334044+0800 GestureLearn[1042:265764] TapGestureRecognizer gestureRecognizerShouldBegin state = 0
     2017-10-11 19:35:04.334504+0800 GestureLearn[1042:265764] TapGesture selector
     2017-10-11 19:35:04.451998+0800 GestureLearn[1042:265764] TapGestureRecognizer shouldReceiveTouch state = 0
     2017-10-11 19:35:04.452230+0800 GestureLearn[1042:265764] UITapGestureRecognizer shouldReceiveTouch state = 0
     2017-10-11 19:35:04.499591+0800 GestureLearn[1042:265764] TapGestureRecognizer gestureRecognizerShouldBegin state = 0
     2017-10-11 19:35:04.499892+0800 GestureLearn[1042:265764] UITapGestureRecognizer gestureRecognizerShouldBegin state = 0
     2017-10-11 19:35:04.500173+0800 GestureLearn[1042:265764] 1111TapGesture selector
     
     加了之后双击屏幕
     2017-10-11 19:35:46.290669+0800 GestureLearn[1044:266214] TapGestureRecognizer shouldReceiveTouch state = 0
     2017-10-11 19:35:46.290906+0800 GestureLearn[1044:266214] UITapGestureRecognizer shouldReceiveTouch state = 0
     2017-10-11 19:35:46.387571+0800 GestureLearn[1044:266214] TapGestureRecognizer gestureRecognizerShouldBegin state = 0
     2017-10-11 19:35:46.489673+0800 GestureLearn[1044:266214] UITapGestureRecognizer shouldReceiveTouch state = 0
     2017-10-11 19:35:46.571888+0800 GestureLearn[1044:266214] UITapGestureRecognizer gestureRecognizerShouldBegin state = 0
     2017-10-11 19:35:46.572320+0800 GestureLearn[1044:266214] 1111TapGesture selector
     */
    [tap requireGestureRecognizerToFail:doubleTap];
}

- (void)learnSimultaneouslyDelegate:(TapGestureRecognizer *)tap view:(GestureView *)view {
    DoubleTapGestureRecognizer *doubleTap = [[DoubleTapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapSelector:)];
    [view addGestureRecognizer:doubleTap];
    doubleTap.delegate = self;
    doubleTap.numberOfTapsRequired = 2;
//    [tap requireGestureRecognizerToFail:doubleTap];
    
    TripleTapGestureRecognizer *tripleTap = [[TripleTapGestureRecognizer alloc] initWithTarget:self action:@selector(tripleTapSelector:)];
    [view addGestureRecognizer:tripleTap];
    tripleTap.delegate = self;
    tripleTap.numberOfTapsRequired = 3;
}

- (void)learnRequireFailureDelegate:(TapGestureRecognizer *)tap view:(GestureView *)view {
    tap.delegate = nil;
    [view removeGestureRecognizer:tap];
    
    UISwipeGestureRecognizer *swipeGestureRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeSelector:)];
    swipeGestureRight.delegate = self;
    swipeGestureRight.direction = UISwipeGestureRecognizerDirectionRight;
    [view addGestureRecognizer:swipeGestureRight];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panSelector:)];
    panGesture.delegate = self;
    [view addGestureRecognizer:panGesture];
    
    self.switcher0 = [[UISwitch alloc] initWithFrame:CGRectMake(50, 550, 20, 20)];
    self.switcher0.on = YES;
    [self.view addSubview:self.switcher0];
    
    self.switcher1 = [[UISwitch alloc] initWithFrame:CGRectMake(250, 550, 20, 20)];
    self.switcher1.on = YES;
    [self.view addSubview:self.switcher1];
}

- (void)selector:(id)sender {
    NSLog(@"TapGesture selector");
}

- (void)doubleTapSelector:(id)sender {
    NSLog(@"DoubleTapGesture selector");
}

- (void)tripleTapSelector:(id)sender {
    NSLog(@"TripleTapGesture selector");
}

- (void)swipeSelector:(id)sender {
    NSLog(@"SwipeGesture selector");
}

- (void)panSelector:(id)sender {
    static int i = 0;
    i++;
    if (i % 5 == 1) {
        NSLog(@"PanGesture selector");
    }
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"ViewController touchesBegan");
//    NSLog(@" ");
//    [super touchesBegan:touches withEvent:event];
//}
//
//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"ViewController touchesMoved");
//    NSLog(@" ");
//    [super touchesMoved:touches withEvent:event];
//}
//
//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"ViewController touchesEnded");
//    NSLog(@" ");
//    [super touchesEnded:touches withEvent:event];
//}
//
//- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"ViewController touchesCancelled");
//    NSLog(@" ");
//    [super touchesCancelled:touches withEvent:event];
//}

#pragma mark -
#pragma mark - UIGestureRecognizerDelegate
/**
 在pointInside hitTest之后 touchesBegan之前调用
 return YES时 gestureRecognizer 会识别该手势
 return NO时 gestureRecognizer 不会识别该手势
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    NSLog(@"%@ shouldReceiveTouch state = %zd",[gestureRecognizer class],gestureRecognizer.state);
    
    /**
     可设置点击的范围
     CGPoint curp = [touch locationInView:self.imageView];
     if (curp.x <= self.imageView.bounds.size.width*0.5) {
        return NO;
     }else{
        return YES;
     }
     */
    
    /**
     UITapGestureRecognizer和UIButton的点击事件冲突的解决办法
     if ([touch.view isKindOfClass:[UIButton class]]) return NO;
     return YES;
     }
     */
    
    return YES;
}

/** 在touchesBegan之后调用
    手势识别成功 将要由UIGestureRecognizerStatePossible发生改变并将要调用相应selector时调用.
    returning NO (虽然识别成功)不执行该手势识别成功后执行的逻辑 手势状态变成UIGestureRecognizerStateFailed
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//    NSLog(@"%@ gestureRecognizerShouldBegin state = %zd",[gestureRecognizer class],gestureRecognizer.state);
    return YES;
}


/**
 默认为NO 是否允许多个手势同时进行并可控手势方法执行顺序 在识别手势成功gestureRecognizerShouldBegin后后调用
 在已经识别出的手势A还存在时又识别出另一个手势B 会调用该方法 (调用时先识别出的手势参数在前)
 method1:   [gestureRecognizer.delegate gestureRecognizer:A shouldRecognizeSimultaneouslyWithGestureRecognizer:B]
 若method1 返回值为NO 则再次调用该方法 2个参数顺序对调
 method2:   [gestureRecognizer.delegate gestureRecognizer:B shouldRecognizeSimultaneouslyWithGestureRecognizer:A]
 
 情况一:若method1 return:YES 不调用method2 手势A同意与手势B共存 手势A的action先调用 手势B的action后调用
     2017-10-12 10:39:21.364628+0800 GestureLearn[1428:372755] shouldRecognizeSimultaneously I:TapGestureRecognizer 3 Other:DoubleTapGestureRecognizer 3
     2017-10-12 10:39:21.364870+0800 GestureLearn[1428:372755] DoubleTapGesture selector
     2017-10-12 10:39:21.365224+0800 GestureLearn[1428:372755] TapGesture selector
 
 情况二:若method1 return:NO method2 return:YES 手势B同意与手势A共存 手势B的action先调用 手势A的action后调用
     2017-10-12 10:44:35.848108+0800 GestureLearn[1437:374577] shouldRecognizeSimultaneously I:TapGestureRecognizer 3 Other:DoubleTapGestureRecognizer 3
     2017-10-12 10:44:35.848224+0800 GestureLearn[1437:374577] shouldRecognizeSimultaneously I:DoubleTapGestureRecognizer 3 Other:TapGestureRecognizer 3
     2017-10-12 10:44:35.848455+0800 GestureLearn[1437:374577] DoubleTapGesture selector
     2017-10-12 10:44:35.848827+0800 GestureLearn[1437:374577] TapGesture selector
 
 情况三:若method1 return:NO method2 return:NO 都不同意共存 调用后识别出的方法手势B的action
     2017-10-12 10:45:56.222698+0800 GestureLearn[1442:375125] shouldRecognizeSimultaneously I:TapGestureRecognizer 3 Other:DoubleTapGestureRecognizer 3
     2017-10-12 10:45:56.222805+0800 GestureLearn[1442:375125] shouldRecognizeSimultaneously I:DoubleTapGestureRecognizer 3 Other:TapGestureRecognizer 3
     2017-10-12 10:45:56.223112+0800 GestureLearn[1442:375125] DoubleTapGesture selector
 
 设置[tap requireGestureRecognizerToFail:doubleTap]后的情况二如下 说明由代理方法判断某个手势能执行的前提下 再通过requireGestureRecognizerToFail判断手势的action是否允许执行
     2017-10-12 10:47:09.709354+0800 GestureLearn[1448:375877] shouldRecognizeSimultaneously I:TapGestureRecognizer 3 Other:DoubleTapGestureRecognizer 3
     2017-10-12 10:47:09.709455+0800 GestureLearn[1448:375877] shouldRecognizeSimultaneously I:DoubleTapGestureRecognizer 3 Other:TapGestureRecognizer 3
     2017-10-12 10:47:09.709726+0800 GestureLearn[1448:375877] DoubleTapGesture selector
 
 ps:可以自行添加tripleTap予以佐证
    讨论的是第二次点击时的执行逻辑 在不设置requireGestureRecognizerToFail的前提下 第一次点击仍一直会调用TapGesture selector
 
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    NSLog(@"shouldRecognizeSimultaneously I:%@ %zd Other:%@ %zd",[gestureRecognizer class],gestureRecognizer.state,[otherGestureRecognizer class],otherGestureRecognizer.state);
    if ([gestureRecognizer isKindOfClass:[TapGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[DoubleTapGestureRecognizer class]]) {
        return NO;
    } else if ([gestureRecognizer isKindOfClass:[DoubleTapGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[TapGestureRecognizer class]]) {
        return NO;
    }
    return NO;
}

// not finished 通过requireGestureRecognizerToFail及shouldRecognizeSimultaneouslyWithGestureRecognizer即可在多手势下判断识别哪个手势
// called once per attempt to recognize, so failure requirements can be determined lazily and may be set up between recognizers across view hierarchies
// return YES to set up a dynamic failure requirement between gestureRecognizer and otherGestureRecognizer
//
// note: returning YES is guaranteed to set up the failure requirement. returning NO does not guarantee that there will not be a failure requirement as the other gesture's counterpart delegate or subclass methods may return YES
/**
 有两个手势A B同时在识别过程中 在第一次shouldReceiveTouch之后 gestureRecognizerShouldBegin手势识别成功之前调用
 若先识别出A手势 
 会调用 [gestureRecognizer.delegate gestureRecognizer:B shouldRequireFailureOfGestureRecognizer:A] B的识别是否以A识别失败作为前提
        return YES 当识别A手势成功后不识别B手势
        
        return NO 调用 [gestureRecognizer.delegate gestureRecognizer:B shouldBeRequiredToFailByGestureRecognizer:A] B识别失败了才会识别A
            return YES 当B识别成功 不识别A手势 当B识别失败 识别A手势
            return NO  会调换参数执行 method1 method2... not finished
 
 method1:shouldRequireFailureOfGestureRecognizer
 method2:shouldBeRequiredToFailByGestureRecognizer
 同时在view上加swipe和pan手势 若默认识别出的是pan手势
 情况一:method1 return:YES
     2017-10-12 11:50:54.776724+0800 GestureLearn[1552:391579] RequireFailure I:UISwipeGestureRecognizer 0 Other:UIPanGestureRecognizer 0
     2017-10-12 11:52:26.132561+0800 GestureLearn[1552:391579] PanGesture selector
 情况二:method1 return:NO method2 return:YES
     2017-10-12 11:52:50.368593+0800 GestureLearn[1552:391579] RequireFailure I:UISwipeGestureRecognizer 0 Other:UIPanGestureRecognizer 0
     2017-10-12 11:52:50.368705+0800 GestureLearn[1552:391579] BeRequiredToFail I:UISwipeGestureRecognizer 0 Other:UIPanGestureRecognizer 0
     2017-10-12 11:52:50.394199+0800 GestureLearn[1552:391579] SwipeGesture selector
 情况三:method1 return:YES method2 return:NO
     2017-10-12 11:55:16.588896+0800 GestureLearn[1552:391579] RequireFailure I:UISwipeGestureRecognizer 0 Other:UIPanGestureRecognizer 0
     2017-10-12 11:55:16.650944+0800 GestureLearn[1552:391579] PanGesture selector
 情况四:method1 return:NO method2 return:NO
     2017-10-12 11:55:44.369618+0800 GestureLearn[1552:391579] RequireFailure I:UISwipeGestureRecognizer 0 Other:UIPanGestureRecognizer 0
     2017-10-12 11:55:44.369721+0800 GestureLearn[1552:391579] BeRequiredToFail I:UISwipeGestureRecognizer 0 Other:UIPanGestureRecognizer 0
     2017-10-12 11:55:44.369846+0800 GestureLearn[1552:391579] RequireFailure I:UIPanGestureRecognizer 0 Other:UISwipeGestureRecognizer 0
     2017-10-12 11:55:44.369934+0800 GestureLearn[1552:391579] BeRequiredToFail I:UIPanGestureRecognizer 0 Other:UISwipeGestureRecognizer 0
     2017-10-12 11:55:44.449607+0800 GestureLearn[1552:391579] PanGesture selector
 
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([NSStringFromClass(otherGestureRecognizer.class) isEqualToString:@"_UISystemGestureGateGestureRecognizer"]) return NO;
    NSLog(@"RequireFailure I:%@ %zd Other:%@ %zd",[gestureRecognizer class],gestureRecognizer.state,[otherGestureRecognizer class],otherGestureRecognizer.state);
    return self.switcher0.isOn;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    NSLog(@"BeRequiredToFail I:%@ %zd Other:%@ %zd",[gestureRecognizer class],gestureRecognizer.state,[otherGestureRecognizer class],otherGestureRecognizer.state);
    return self.switcher1.isOn;
}




//
//// called before pressesBegan:withEvent: is called on the gesture recognizer for a new press. return NO to prevent the gesture recognizer from seeing this press
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceivePress:(UIPress *)press;










@end

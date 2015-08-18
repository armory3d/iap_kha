#include <IAPKore.h>

#import <CoreFoundation/CoreFoundation.h>
#import <StoreKit/StoreKit.h>
#import <UIKit/UIKit.h>

@interface InAppPurchase: NSObject <SKProductsRequestDelegate, SKPaymentTransactionObserver>

@end

@implementation InAppPurchase

- (id)init{
    self = [super init];
    return self;
}

- (void)purchaseProduct:(NSString*)productId{
    //NSLog(@"User requests to remove ads");

    if([SKPaymentQueue canMakePayments]){
        //NSLog(@"User can make payments");

        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:productId]];
        productsRequest.delegate = self;
        [productsRequest start];
    }
    else{
        //NSLog(@"User cannot make payments due to parental controls");
        //this is called the user cannot make payments, most likely due to parental controls
        [self purchaseFailed];
    }
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    SKProduct *validProduct = nil;
    int count = [response.products count];
    if(count > 0){
        validProduct = [response.products objectAtIndex:0];
        //NSLog(@"Products Available!");
        [self purchase:validProduct];
    }
    else if(!validProduct){
        //NSLog(@"No products available");
        //this is called if your product id is not valid, this shouldn't be called unless that happens.
        [self purchaseFailed];
    }
}

- (void)purchase:(SKProduct *)product{
    SKPayment *payment = [SKPayment paymentWithProduct:product];

    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (void) restore{
    //this is called when the user restores purchases, you should hook this up to a button
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

- (void) paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
    //NSLog(@"received restored transactions: %i", queue.transactions.count);
    for(SKPaymentTransaction *transaction in queue.transactions){
        if(transaction.transactionState == SKPaymentTransactionStateRestored){
            //called when the user successfully restores a purchase
            //NSLog(@"Transaction state -> Restored");

            [self purchaseFinished];
            [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            break;
        }
    }   
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
    for(SKPaymentTransaction *transaction in transactions){
        switch(transaction.transactionState){
            case SKPaymentTransactionStatePurchasing:
                //NSLog(@"Transaction state -> Purchasing");
                //called when the user is in the process of purchasing, do not add any of your own code here.
                break;
            case SKPaymentTransactionStatePurchased:
            //this is called when the user has successfully purchased the package (Cha-Ching!)
                [self purchaseFinished]; //you can add your code for what you want to happen when the user buys the purchase here, for this tutorial we use removing ads
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                //NSLog(@"Transaction state -> Purchased");
                break;
            case SKPaymentTransactionStateRestored:
                //NSLog(@"Transaction state -> Restored");
                //add the same code as you did from SKPaymentTransactionStatePurchased here
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self purchaseFailed];
                //called when the transaction does not finish
                //NSLog(@"Transaction state -> Failed");
                //if(transaction.error.code == SKErrorPaymentCancelled){
                    //NSLog(@"Transaction state -> Cancelled");
                    //the user cancelled the payment ;(
                //}
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
        }
    }
}

- (void)purchaseFinished{
    IAPKore::setPurchased();
}

- (void)purchaseFailed{
    IAPKore::setError();
}

@end

namespace IAPKore {

	InAppPurchase* iap;

	int init() {
		iap = [[InAppPurchase alloc] init];
		return 0;
	}

	void purchaseProduct(const char* productId) {
        IAPKore::purchaseReceived();
        IAPKore::errorReceived();
		NSString *strProductID = [[NSString alloc] initWithUTF8String:productId];
		[iap purchaseProduct:strProductID];
	}

	void restore() {
        IAPKore::purchaseReceived();
        IAPKore::errorReceived();
        [iap restore];
	}


    bool purchaseCompleted = false;
    bool wasPurchased() {
        return purchaseCompleted;
    }
    void purchaseReceived() {
        purchaseCompleted = false;
    }
    void setPurchased() {
        purchaseCompleted = true;
    }

    bool errorCompleted = false;
    bool wasError() {
        return errorCompleted;
    }
    void errorReceived() {
        errorCompleted = false;
    }
    void setError() {
        errorCompleted = true;
    }
}

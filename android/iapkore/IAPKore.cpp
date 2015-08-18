#include <IAPKore.h>

namespace IAPKore {

	int init() {
		return 0;
	}

	void purchaseProduct(const char* productId) {
        
	}

	void restore() {
        
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

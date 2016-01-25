package iapkore;

import com.ktxsoftware.kore.KoreActivity;

public class IAPKore {
    
	public static void purchaseProduct(String productId) {
		KoreActivity inst = KoreActivity.getInstance();

		inst.purchaseProduct();
	}

	public static void restore() {
		KoreActivity inst = KoreActivity.getInstance();

		inst.restore();
	}

	public static boolean getPurchased() {
		KoreActivity inst = KoreActivity.getInstance();

		boolean result = inst._purchaseCompleted;
		inst._purchaseCompleted = false;
		return result;
	}

	public static boolean getError() {
		KoreActivity inst = KoreActivity.getInstance();

		boolean result = inst._errorCompleted;
		inst._errorCompleted = false;
		return result;
	}
}

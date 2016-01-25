package iap;

#if (sys_ios ||sys_android_native)
@:headerCode('
#include <IAPKore.h>
')
#end

class IAP {

	// TODO: use __cpp__
	#if (sys_ios ||sys_android_native)
	@:functionCode('return IAPKore::init();')
	#end
	public static function init():Int {
		return 0;
	}

	#if (sys_ios ||sys_android_native)
	@:functionCode('IAPKore::purchaseProduct(productId);')
	#end
	public static function purchaseProduct(productId:String) {
	}

	#if (sys_ios ||sys_android_native)
	@:functionCode('IAPKore::restore();')
	#end
	public static function restore() {
	}


	#if (sys_ios ||sys_android_native)
	@:functionCode('return IAPKore::getPurchased();')
	#end
	public static function getPurchased():Bool {
		return false;
	}

	#if (sys_ios ||sys_android_native)
	@:functionCode('return IAPKore::getError();')
	#end
	public static function getError():Bool {
		return false;
	}
}

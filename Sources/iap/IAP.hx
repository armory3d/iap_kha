package iap;

#if sys_ios
@:headerCode('
#include <IAPKore.h>
')
#end

class IAP {

	// TODO: use __cpp__
	#if sys_ios
	@:functionCode('return IAPKore::init();')
	#end
	public static function init():Int {
		return 0;
	}

	#if sys_ios
	@:functionCode('IAPKore::purchaseProduct(productId);')
	#end
	public static function purchaseProduct(productId:String) {
	}

	#if sys_ios
	@:functionCode('IAPKore::restore();')
	#end
	public static function restore() {
	}


	#if sys_ios
	@:functionCode('return IAPKore::wasPurchased();')
	#end
	public static function wasPurchased():Bool {
		return false;
	}

	#if sys_ios
	@:functionCode('IAPKore::purchaseReceived();')
	#end
	public static function purchaseReceived():Void {
	}


	#if sys_ios
	@:functionCode('return IAPKore::wasError();')
	#end
	public static function wasError():Bool {
		return false;
	}

	#if sys_ios
	@:functionCode('IAPKore::errorReceived();')
	#end
	public static function errorReceived():Void {
	}
}

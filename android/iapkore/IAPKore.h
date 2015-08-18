#pragma once

namespace IAPKore {

	int init();
	void purchaseProduct(const char* productId);
	void restore();

	bool wasPurchased();
	void purchaseReceived();
	void setPurchased();

	bool wasError();
	void errorReceived();
	void setError();
}

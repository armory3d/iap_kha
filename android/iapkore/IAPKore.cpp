#include <IAPKore.h>

#include <Kore/Android.h>

namespace IAPKore {

	int init() {
		return 0;
	}

	void purchaseProduct(const char* productId) {
        JNIEnv* env;
        KoreAndroid::getActivity()->vm->AttachCurrentThread(&env, NULL);

        jclass cls = KoreAndroid::findClass(env, "iapkore.IAPKore");

        jmethodID methodId = env->GetStaticMethodID(cls, "purchaseProduct", "(Ljava/lang/String;)V");
        jstring jid = env->NewStringUTF(productId);

        env->CallStaticVoidMethod(cls, methodId, jid);

        KoreAndroid::getActivity()->vm->DetachCurrentThread();
	}

	void restore() {
        JNIEnv* env;
        KoreAndroid::getActivity()->vm->AttachCurrentThread(&env, NULL);

        jclass cls = KoreAndroid::findClass(env, "iapkore.IAPKore");

        jmethodID methodId = env->GetStaticMethodID(cls, "restore", "()V");

        env->CallStaticVoidMethod(cls, methodId);

        KoreAndroid::getActivity()->vm->DetachCurrentThread();
	}

    bool getPurchased() {
        JNIEnv* env;
        KoreAndroid::getActivity()->vm->AttachCurrentThread(&env, NULL);

        jclass cls = KoreAndroid::findClass(env, "iapkore.IAPKore");

        jmethodID methodId = env->GetStaticMethodID(cls, "getPurchased", "()Z");

        bool result = env->CallStaticBooleanMethod(cls, methodId);

        KoreAndroid::getActivity()->vm->DetachCurrentThread();

        return result;
    }

    bool getError() {
        JNIEnv* env;
        KoreAndroid::getActivity()->vm->AttachCurrentThread(&env, NULL);

        jclass cls = KoreAndroid::findClass(env, "iapkore.IAPKore");

        jmethodID methodId = env->GetStaticMethodID(cls, "getError", "()Z");

        bool result = env->CallStaticBooleanMethod(cls, methodId);

        KoreAndroid::getActivity()->vm->DetachCurrentThread();

        return result;
    }
}

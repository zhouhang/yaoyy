package com.ms.biz.properties;

import org.springframework.stereotype.Component;

/**
 * Created by wangbin on 2017/1/3.
 */
@Component
public class AliPayProperties {


    private String appId ="2016122604638115";

    private String private_key = "MIIEwAIBADANBgkqhkiG9w0BAQEFAASCBKowggSmAgEAAoIBAQCRD+vPzpWz9ZNgk/30lwIFLtHULRkJMQCVaw8LYozq+h8NOiLaV1i2fi4pDogzF4LpDrY1X6GkZahgCruA+oddFWkvThwFu51K7r7BOclRBHB5QR9hwPkp06fpagiJ4D6BRUlMccOKCCr4itkJkIX/sF/3EYAZylN0mODICj5YOKf2BBLPMSvLLECZ/MHN6Z4k9tPa4ZcHiUmEP5lHj+94K6noPrFmYwwbP/Tl9rRPWZK4XM0wq113wNzLE4bnQKIrsi9uWG0vL3+9GWDtfM3YmhwTqR880butKr3yE4ZXg+lgVzwysV19mMB8CKSUfDu+14Nt4ECjmDxucBV4kks5AgMBAAECggEBAIEPHCrHTlNMgnFjWYb5rtdzn0VZVjPiP/WvyTPE20DXhTbcaVO+cHP0cRcgEbb7DQJSj3OPAJ3lv9aq1cVbn4EGYo2uvamwELIxFM+OnPiSrYqDkOsEp+k5oOM+7hfUxWd3gE4dzO2KdMipp40l4sHoZojHLiRD6NoMhbgTvQH5FxerP9z4kULljcdNX7WehW0+ASd1b4bqgVo7cgFeowgZgRlYl5fn9v2Y6owVlfTGvM69p1PTfabyDoOXCJTYvZEIFj4JAR1D15DnfUn1MHuibYD0Ov3EEyW/L9k7fnYet+VSh5pErsKX0mr9zWco6cS8bkr09swaUAy9ktRp510CgYEAxffpoc9U1ldMJ5Gr9N0TazaU9aTnOOUgsseWX1XMbMsz8P8VD1Gao+F6QAi53QCmqrMYMJBVz2CncjZKHJQc6NL/OeM9yMWgw05dBj3SuI+ApbsilWRBZGPe15VhE9TOBy1I2v8KI+3DxmzAkXJoXiKJOG2PXrqamHS+vZpsIh8CgYEAu5XIQJaXQ9Xwb7u+Y4KsHYPdlnH6CdoPlRQXTQWsC6qdyiuz7DNIFJroyDEBI1vnEERFOwfuG2uURnGw0HZ1y3jAaj1GqmidIQjQLl7Qi/5j4+2OJcSHiczn/7zXA1/Lx3p1Ny9gJWPzP+aq/x8C+JwQP/vPY3h9u/gxXWig16cCgYEAmTXkenYbEkc9iOIUUs1F2hPD9NhKmp25UKNmnSGptAkPidPgWJqvM2WtVyFptsBqPHGepvcNchE7hgi+EqAOP6IMJKDZkChi4sQi+lGeY3er+Jd7jGKquScRr4bMOqzXRnali9cV4fiBK2+/GNGSNEhGKoWgD5AbVSIE/Hgmd8ECgYEAszCllm1EGhzoDRP/DvfoillI90nxXC/d6r7Cc2UTsCFPkayltuBV3rkL3RBS0gAcfcF5kKZGohLmFVTNXpWKeM/knpfiRS6hysisdV9FQDXGHhjzTMir4MrIY9d0XVjJRMiJ6CltYspTt5sVhZeOMwaBz10wAwk6srCoF163JskCgYEAqUxG/7oM9WstcRVHtfbCHXxN4SkSfB+XlCHCf8VLcktwhEFUsk7bV0A9kRKBE6+w023KFKuTOb2F/yDA46+nWOME0I3C7St7FxQrJ7IHG+IwStHlTh/ICe1HnbJmczyE60VQyP+WUoygAxXq/pmPv83ivDl+bGZXuT0384gTHmU=";

    private String charset = "UTF-8";

    private String public_key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAn7KElqsSWr63t8ZxO2qkoJ0sqvxAtQuQPqhuAJ3z/GTGC40F0dOZnfrzzOTwIUzrqfYToSNPIkie4vaWVIfnjUX+5LkYNmhWVUtDsdPiDFJRvrs+EZ4P2DZk6B7SMrKWqyqRWU0s+UMP2qkNVdfosENaQNJLCkJzZCuA6yxGXfAfXO15ixFD8ctkTJoPuKU17djBYafMhKiFULCixGSu5p9Xp8JerER3VZRcOK7J6lHTFSf8rRN0hjeqBIqjTxbPqsNfVR3jd1bUsex5PP7l6AggYNoarPBArqdyF4EnOW3s0WVifbZyeruD35rQhx0GNMEdA5hOS0MxF31wgkgFXwIDAQAB";

    private String sellerId = "2088521469439302";

    public String getAppId() {
        return appId;
    }

    public String getPrivate_key() {
        return private_key;
    }

    public String getCharset() {
        return charset;
    }

    public String getPublic_key() {
        return public_key;
    }

    public String getSellerId() {
        return sellerId;
    }


}

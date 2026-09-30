import 'package:cesc_commerce/core/globals.dart';

class AddressService {
  Future<List<Map<String, dynamic>>> getAddresses() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return globalAddresses.value;
  }

  Future<void> addAddress(Map<String, dynamic> address) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final current = List<Map<String, dynamic>>.from(globalAddresses.value);
    current.add(address);
    globalAddresses.value = current;
    if (globalSelectedAddressIndex.value == -1) { globalSelectedAddressIndex.value = 0; }
  }

  Future<void> updateAddress(int index, Map<String, dynamic> address) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final current = List<Map<String, dynamic>>.from(globalAddresses.value);
    if (index >= 0 && index < current.length) {
      current[index] = address;
      globalAddresses.value = current;
    }
  }

  Future<void> deleteAddress(int index) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final current = List<Map<String, dynamic>>.from(globalAddresses.value);
    if (index >= 0 && index < current.length) {
      bool wasSelected = index == globalSelectedAddressIndex.value;
      current.removeAt(index);
      
      if (current.isEmpty) {
        globalSelectedAddressIndex.value = -1;
      } else {
        if (index < globalSelectedAddressIndex.value) {
          globalSelectedAddressIndex.value -= 1;
        } else if (wasSelected || globalSelectedAddressIndex.value >= current.length) {
          globalSelectedAddressIndex.value = 0;
          for (int i = 0; i < current.length; i++) {
            current[i]['isDefault'] = (i == 0);
          }
        }
      }
      globalAddresses.value = current;
    }
  }

  Future<void> setDefaultAddress(int index) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final current = List<Map<String, dynamic>>.from(globalAddresses.value);
    if (index >= 0 && index < current.length) {
      for (int i = 0; i < current.length; i++) {
        current[i]['isDefault'] = (i == index);
      }
      globalAddresses.value = current;
      globalSelectedAddressIndex.value = index;
    }
  }
}

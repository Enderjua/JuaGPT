import 'dart:ffi' as ffi;

typedef AddFunc = ffi.Int32 Function(ffi.Int32, ffi.Int32);
typedef Add = int Function(int, int);

void main() {
  // Mutlak yol ile dinamik kütüphaneyi yüklemeyi deneyin
  final dylib = ffi.DynamicLibrary.open('/home/marijua/Masaüstü/all/software/flutter/juagpt/lib/backend/liblib.so'); // Dosya yolunu kontrol edin
  final Add add = dylib.lookup<ffi.NativeFunction<AddFunc>>('add').asFunction();
  
  final result = add(3, 4);
  print('$result');
}

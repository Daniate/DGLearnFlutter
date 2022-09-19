//
// Created by daniate on 2022/9/19.
//

#ifndef FLUTTER_FFI_FFI_API_IN_CPP_H
#define FLUTTER_FFI_FFI_API_IN_CPP_H

#ifdef __cplusplus
#define EXTERN_C extern "C"
#else
#define EXTERN_C
#endif

EXTERN_C int native_add_in_cpp(int x, int y);

#endif //FLUTTER_PLUGIN_MY_FFI_FFI_API_IN_CPP_H

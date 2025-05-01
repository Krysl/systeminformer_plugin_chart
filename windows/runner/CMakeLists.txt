cmake_minimum_required(VERSION 3.14)
project(runner LANGUAGES CXX)


set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_EXT "")
set(SYSTEM_INFORMER_LIB_DIR "")
message(STATUS "CMAKE_SYSTEM_PROCESSOR = ${CMAKE_SYSTEM_PROCESSOR}")
if(CMAKE_SYSTEM_PROCESSOR MATCHES "AMD64")
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_EXT 64)
  set(SYSTEM_INFORMER_LIB_DIR "amd64")
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "X86")
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_EXT 32)
  set(SYSTEM_INFORMER_LIB_DIR "i386")
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "ARM64")
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_EXT ARM64)
  set(SYSTEM_INFORMER_LIB_DIR "arm64")
endif()

set(CMAKE_BINARY_DIR $ENV{SYSTEMINFORMER_GIT_FOLDER})
message(STATUS "Using environment variable SYSTEMINFORMER_GIT_FOLDER: ${CMAKE_BINARY_DIR}")

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/bin/Debug${CMAKE_RUNTIME_OUTPUT_DIRECTORY_EXT}/plugins)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/bin/Release${CMAKE_RUNTIME_OUTPUT_DIRECTORY_EXT}/plugins)

message(STATUS "debug   output dir: ${CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG}")
message(STATUS "release output dir: ${CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE}")

# Define the application target. To change its name, change BINARY_NAME in the
# top-level CMakeLists.txt, not the value here, or `flutter run` will no longer
# work.
#
# Any new source files that you add to the application should be added here.
add_library(${BINARY_NAME} SHARED
  "flutter_window.cpp"
  "main.cpp"
  "dllmain.cpp"
  "messages.g.cpp"
  "api.cpp"
  "utils.cpp"
  "win32_window.cpp"
  "${FLUTTER_MANAGED_DIR}/generated_plugin_registrant.cc"
  "Runner.rc"
  "runner.exe.manifest"
)

# Apply the standard set of build settings. This can be removed for applications
# that need different build settings.
apply_standard_settings(${BINARY_NAME})

# Add preprocessor definitions for the build version.
target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION=\"${FLUTTER_VERSION}\"")
target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION_MAJOR=${FLUTTER_VERSION_MAJOR}")
target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION_MINOR=${FLUTTER_VERSION_MINOR}")
target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION_PATCH=${FLUTTER_VERSION_PATCH}")
target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION_BUILD=${FLUTTER_VERSION_BUILD}")

# Disable Windows macros that collide with C++ standard library functions.
target_compile_definitions(${BINARY_NAME} PRIVATE "NOMINMAX")

# Add dependency libraries and include directories. Add any application-specific
# dependencies here.
target_link_libraries(${BINARY_NAME} PRIVATE flutter flutter_wrapper_app)
target_link_libraries(${BINARY_NAME} PRIVATE "dwmapi.lib")
target_link_libraries(${BINARY_NAME} PRIVATE "${CMAKE_SOURCE_DIR}/../sdk/lib/${SYSTEM_INFORMER_LIB_DIR}/SystemInformer.lib")
target_include_directories(${BINARY_NAME} PRIVATE "${CMAKE_SOURCE_DIR}")
target_include_directories(${BINARY_NAME} PRIVATE "../../sdk/include")

# Run the Flutter tool portions of the build. This must not be removed.
add_dependencies(${BINARY_NAME} flutter_assemble)

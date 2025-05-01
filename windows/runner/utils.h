#ifndef RUNNER_UTILS_H_
#define RUNNER_UTILS_H_

#include <memory>
#include <string>
#include <vector>

// Creates a console for the process, and redirects stdout and stderr to
// it for both the runner and the Flutter library.
void CreateAndAttachConsole();

// Takes a null-terminated wchar_t* encoded in UTF-16 and returns a std::string
// encoded in UTF-8. Returns an empty std::string on failure.
std::string Utf8FromUtf16(const wchar_t *utf16_string);

// Gets the command line arguments passed in as a std::vector<std::string>,
// encoded in UTF-8. Returns an empty std::vector<std::string> on failure.
std::vector<std::string> GetCommandLineArguments();

#define _PWSTR(str) (const_cast<PWSTR>(str))
std::string toStdString(PWSTR pwch);
std::string toStdString(PPH_STRING pwch);
std::unique_ptr<PWCHAR> toPWSTR(std::string str);
PCPH_STRINGREF toPCPH_STRINGREF(std::string str, PH_STRINGREF &sr);

#endif // RUNNER_UTILS_H_

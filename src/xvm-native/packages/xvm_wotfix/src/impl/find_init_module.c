/**
 * XVM Native WOTFix module
 * @author Mikhail Paulyshka <mixail(at)modxvm.com>
 */

#include <Windows.h>

#define SEP L'\\'
#define ALTSEP L'/'
#define MAXPATHLEN 256

__declspec(dllexport) int _cdecl find_init_module_replacement(char *buf)
{
    const size_t save_len = strlen(buf);
    size_t i = save_len;
    char *pname;
    int rv;

    if (save_len + 13 >= MAXPATHLEN)
    {
        return 0;
    }

    buf[i++] = SEP;
    pname = buf + i;
    strcpy(pname, "__init__.py");
    rv = GetFileAttributesA(buf);
    if ((rv != INVALID_FILE_ATTRIBUTES) && !(rv&FILE_ATTRIBUTE_DIRECTORY))
    {
        buf[save_len] = '\0';
        return 1;
    }

    i += strlen(pname);
    strcpy(buf + i, "c");
    rv = GetFileAttributesA(buf);
    if ((rv != INVALID_FILE_ATTRIBUTES) && !(rv&FILE_ATTRIBUTE_DIRECTORY))
    {
        buf[save_len] = '\0';
        return 1;
    }

    buf[save_len] = '\0';
    return 0;
}
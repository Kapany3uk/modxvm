/**
 * XVM Native XPFix module
 * @author Mikhail Paulyshka <mixail(at)modxvm.com>
 */

#include "dllmain.h"
#include "injector.h"

BOOL WINAPI DllMain(IN HINSTANCE hDllHandle, IN DWORD nReason, IN LPVOID Reserved) 
{
    switch ( nReason ) 
    {
        case DLL_PROCESS_ATTACH:
            injector();
            break;
        default:
            break;
    }

    return TRUE;
}
unit ZPriv;

interface
uses Windows, SysUtils;

const
  SE_CREATE_TOKEN_NAME = 'SeCreateTokenPrivilege';
  SE_ASSIGNPRIMARYTOKEN_NAME = 'SeAssignPrimaryTokenPrivilege';
  SE_LOCK_MEMORY_NAME = 'SeLockMemoryPrivilege';
  SE_INCREASE_QUOTA_NAME = 'SeIncreaseQuotaPrivilege';
  SE_UNSOLICITED_INPUT_NAME = 'SeUnsolicitedInputPrivilege';
  SE_MACHINE_ACCOUNT_NAME = 'SeMachineAccountPrivilege';
  SE_TCB_NAME = 'SeTcbPrivilege';
  SE_SECURITY_NAME = 'SeSecurityPrivilege';
  SE_TAKE_OWNERSHIP_NAME = 'SeTakeOwnershipPrivilege';
  SE_LOAD_DRIVER_NAME = 'SeLoadDriverPrivilege';
  SE_SYSTEM_PROFILE_NAME = 'SeSystemProfilePrivilege';
  SE_SYSTEMTIME_NAME = 'SeSystemtimePrivilege';
  SE_PROF_SINGLE_PROCESS_NAME = 'SeProfileSingleProcessPrivilege';
  SE_INC_BASE_PRIORITY_NAME = 'SeIncreaseBasePriorityPrivilege';
  SE_CREATE_PAGEFILE_NAME = 'SeCreatePagefilePrivilege';
  SE_CREATE_PERMANENT_NAME = 'SeCreatePermanentPrivilege';
  SE_BACKUP_NAME = 'SeBackupPrivilege';
  SE_RESTORE_NAME = 'SeRestorePrivilege';
  SE_SHUTDOWN_NAME = 'SeShutdownPrivilege';
  SE_DEBUG_NAME = 'SeDebugPrivilege';
  SE_AUDIT_NAME = 'SeAuditPrivilege';
  SE_SYSTEM_ENVIRONMENT_NAME = 'SeSystemEnvironmentPrivilege';
  SE_CHANGE_NOTIFY_NAME = 'SeChangeNotifyPrivilege';
  SE_REMOTE_SHUTDOWN_NAME = 'SeRemoteShutdownPrivilege';

function AdjustPriviliges(const PrivelegStr: string): Bool; forward;

implementation

function AdjustPriviliges(const PrivelegStr: string): Bool;
var
  hTok: THandle;
  tp: TTokenPrivileges;
begin
  Result := False;
  // Get the current process token handle so we can get privilege.
  if OpenProcessToken(GetCurrentProcess, TOKEN_ADJUST_PRIVILEGES + TOKEN_QUERY,
    hTok) then
  try
    // Get the LUID for privilege.
    if LookupPrivilegeValue(nil, PChar(PrivelegStr), tp.Privileges[0].Luid) then
    begin
      tp.PrivilegeCount := 1; // one privilege to set
      tp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
      // Get privilege for this process.
      Result := AdjustTokenPrivileges(hTok, False, tp, 0,
        PTokenPrivileges(nil)^, PDWord(nil)^)
    end
  finally
    // Cannot test the return value of AdjustTokenPrivileges.
    if (GetLastError <> ERROR_SUCCESS) then
      raise Exception.Create('AdjustTokenPrivileges enable failed');
    CloseHandle(hTok)
  end
  else
    raise Exception.Create('OpenProcessToken failed');
end;

end.
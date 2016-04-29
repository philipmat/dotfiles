# install.ps1
param(
    [switch]$verbose=false
    [switch]$test=false
)

# Create a new symbolic link file named MySymLinkFile.txt in C:\Temp which links to $pshome\profile.ps1
# New-Item -ItemType SymbolicLink -Name C:\Temp\MySymLinkFile.txt -Value $pshome\profile.ps1


function Is-ReparsePoint([string]$path) {
    # http://stackoverflow.com/questions/817794/find-out-whether-a-file-is-a-symbolic-link-in-powershell
    $file = Get-Item $path -Force -ea 0
    return [bool]($file.Attributes -band [IO.FileAttributes]::ReparsePoint)
}

<#
            var flags = 0;

            if (target is DirectoryInfo)
            {
                flags = 1 // SYMLINK_FLAG_DIRECTORY;
            }

            if (ShouldProcess(TargetPath.ProviderPath,
                String.Format("New symbolic link via {0}", LiteralPath.ProviderPath)))
            {
                if (!NativeMethods.CreateSymbolicLink(LiteralPath.ProviderPath, TargetPath.ProviderPath, flags))
                
  
        [DllImport(Dll.Kernel32, SetLastError = true, CharSet = CharSet.Unicode)]
        [ReliabilityContract(Consistency.WillNotCorruptState, Cer.MayFail)]
        public static extern bool CreateSymbolicLink(string lpSymlinkFileName, string lpTargetFileName, int dwFlags);              
#>

# also
# https://gist.github.com/jpoehls/2891103


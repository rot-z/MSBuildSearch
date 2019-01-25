# =============================================================================
#     search MSBuild.exe 
# =============================================================================

# folder paths of Visual Studio
$MSBUILD_14_PATH = "MSBuild`\14.0`\Bin"                                                         # Visual Studio 2015版のMSBuildインストールパス
$MSBUILD_15_COMMUNITY_PATH = "Microsoft Visual Studio`\2017`\Community`\MSBuild`\15.0`\Bin"     # Visual Studio 2017 Community版のMSBuildインストールパス

# target paths for MSBuild
# sort by priority
[array]$SEARCH_PATHS = @(
        $MSBUILD_14_PATH, 
        $MSBUILD_15_COMMUNITY_PATH
    )

# get full path of "Program Files" folder from OS archtechture
$arch = (Get-WmiObject win32_operatingsystem | Select-Object osarchitecture)
$archName = $arch.osarchitecture
$programFilesDir = ""
if ($archName.StartsWith("64"))
{
    $programFilesDir = ${env:ProgramFiles(x86)}
}
else
{
    $programFilesDir = ${env:ProgramFiles}
}

# search MSBuild.exe
$msbuildPath = ""
foreach($p in $SEARCH_PATHS)
{
    # is folder exists?
    $targetPath = Join-Path $programFilesDir $p
    if (!(Test-Path $targetPath)) 
    {
        continue
    }

    # select the most shortest (shallowest) path
    $results = (Get-ChildItem $targetPath -Include MSBuild.exe -Recurse).FullName | Sort-Object -Property Length
    if ($results.Length -gt 0)
    {
        $msbuildPath = $results[0]
        Write-host $msbuildPath
    }
}

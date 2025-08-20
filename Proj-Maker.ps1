function MakeProj {
    param ([string]$directory_name)
    if (-not (Test-Path $directory_name)){
        New-Item -Path $directory_name -ItemType Directory
    }

    if (-not (Test-Path "$directory_name\src")){
        New-Item -Path "$directory_name\src" -ItemType Directory
    }

    if (-not (Test-Path "$directory_name\src\main.csx")){
        New-Item -Path "$directory_name\src\main.csx" -ItemType File
    }

    $core_library = "System.Private.Corelib.dll";
    $print_library = "System.Console.dll"

    Set-Content -Path "$directory_name\src\main.csx" -Value @(
    "#r `"$core_library`" ",
    "#r `"$print_library`"",
    "System.Console.Write(`"Hello, world!`")"
    )

    if (-not (Test-Path "$directory_name\.vscode")){
        New-Item -Path "$directory_name\.vscode" -ItemType Directory
    }

    if (-not (Test-Path "$directory_name\.vscode\settings.json")){
        New-Item -Path "$directory_name\.vscode\settings.json" -ItemType File
    }
    Set-Content "$directory_name\.vscode\settings.json" @(
    "{",
    "`"code-runner.clearPreviousOutput`": true,",
    "`"code-runner.runInTerminal`": true,",
    "`"code-runner.fileDirectoryAsCwd`": true,",
    "`"code-runner.executorMap`": {",
    "   `"csharp`":`"dotnet-script`"",
    "   }",
    "}"
    )

    if (-not (Test-Path "$directory_name\README.md")){
        New-Item -Path "$directory_name\README.md" -ItemType File
    }

    Set-Content "$directory_name\README.md" @(
        "# $directory_name"
    )
}
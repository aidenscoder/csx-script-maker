function MakeProj {
    param ([string]$directory_name)
    if (-not (Test-Path $directory_name)){
        New-Item -Path $directory_name -ItemType Directory
    }
    if (-not (Test-Path $directory_name)){
        New-Item -Path "$directory_name\main.csx" -ItemType File
    }
    $core_library = "System.Private.Corelib.dll";
    $print_library = "System.Console.dll"
    Set-Content -Path "$directory_name\main.csx" -Value @(
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
    "`"code-runner.executorMap`": {",
    "   `"csharp`":`"%dotnet-script%`"",
    "   }",
    "}"
    )
}

MakeProj("MyProj")
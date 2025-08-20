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

    if (-not (Test-Path "$directory_name\modules")){
        New-Item -Path "$directory_name\modules" -ItemType Directory
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

    if (-not (Test-Path "$directory_name\import-update.py")){
        New-Item -Path "$directory_name\import-update.py" -ItemType File
    }

    Set-Content "$directory_name\import-update.py" @(
    "import os",
    "",
    "directory = `"$directory_name\\modules`"",
    "files = os.listdir(directory)",
    "importing_lines = `"`"",
    "for file in files:",
    '   importing_lines += f"#load f"#load \"{directory+"/"+file}\"" ',
    "",
    "with open(`"$directory_name\\src\\main.csx`",`"r`") as file:",
    "    content = file.read()",
    "    content = content.split(`"\n`")",
    "    content[0] = importing_lines",
    "    join = `"`"",
    "    for i in content:",
    "        join += i+`"\n`"",
    "",
    "with open(`"$directory_name\\src\\main.csx`",`"w`") as file:",
    "   file.write(join)"
    )
}

MakeProj("proj")
import os

directory = "proj\\modules"
files = os.listdir(directory)
importing_lines = ""
for file in files:
   importing_lines += f"#load f"#load \"{directory+"/"+file}\"" 

with open("proj\\src\\main.csx","r") as file:
    content = file.read()
    content = content.split("\n")
    content[0] = importing_lines
    join = ""
    for i in content:
        join += i+"\n"

with open("proj\\src\\main.csx","w") as file:
   file.write(join)

import glob
for f in glob.glob("/home/qwerty/mathwiz.nvim/lua/mathviz/languages/*.lua"):
    with open(f, "r") as file:
        data = file.read()
    data = data.replace('text:match("^([a-zA-Z]+)_([a-zA-Z0-9]+)$")', 'text:match("^([a-zA-Z]+)_([a-zA-Z0-9]*)$")')
    with open(f, "w") as file:
        file.write(data)
print("Done")

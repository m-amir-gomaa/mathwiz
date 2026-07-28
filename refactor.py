import glob
import re

for filepath in glob.glob("lua/mathviz/languages/*.lua"):
    with open(filepath, "r") as f:
        content = f.read()

    # 1. Inject the require statement at the top of the file if it's not there
    if 'require("mathviz.features.symbols")' not in content:
        content = re.sub(
            r'local M = \{\}',
            'local M = {}\nlocal symbols_module = require("mathviz.features.symbols")\nlocal symbol_map = symbols_module.symbol_map\nlocal subscript_map = symbols_module.subscript_map',
            content
        )

    # 2. Delete the old local symbol_map definitions
    content = re.sub(r'local symbol_map = \{[^}]+\}', '', content, flags=re.MULTILINE)
    content = re.sub(r'local greek_map = \{[^}]+\}', '', content, flags=re.MULTILINE)
    
    # 3. Delete old subscript_map definitions
    content = re.sub(r'local subscript_map = \{[^}]+\}', '', content, flags=re.MULTILINE)

    # 4. We need to make sure the symbols loop references symbol_map and subscript_map.
    # We already made sure it does in the previous patch which changed `greek_map` lookups to `symbol_map`. Wait, did we? The previous patch might have left `greek_map` in some files.
    content = content.replace("greek_map", "symbol_map")

    with open(filepath, "w") as f:
        f.write(content)

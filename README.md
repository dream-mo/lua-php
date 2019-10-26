# lua-php
Use LUA language to implement common functions of PHP.
It is convenient for phper to call some common functions, you don't need to implement it yourself. 
Because lua is relatively lightweight compared to php, there are not many built-in functions, 
generally extending it yourself or looking for third-party extensions in https://luarocks.org/
#### quick start
```lua
PHP = require("src/lua-php")

person = {name = "lua-php", version="1.0.0"}

PHP.var_dump(person)
```
print struct:

table(2) {
    <br/> 
&nbsp;&nbsp;&nbsp;&nbsp;string(2)"name"=>string(7)"lua-php",
&nbsp;&nbsp;&nbsp;&nbsp;string(7)"version"=>string(5)"1.0.0"
   <br/>
}
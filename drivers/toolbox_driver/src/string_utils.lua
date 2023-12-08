local m = {}

--- http://lua-users.org/wiki/StringRecipes
function m.starts_with(str, prefix)
  return string.sub(str, 1, #prefix) == prefix
end

--- http://lua-users.org/wiki/StringRecipes
function m.ends_with(str, suffix)
  return suffix == "" or string.sub(str, -#suffix) == suffix
end

return m

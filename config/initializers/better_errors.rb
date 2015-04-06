# BetterErrors.editor = :atom if defined? BetterErrors
if defined? BetterErrors
  BetterErrors.editor = "atm://open?url=file://%{file}&line=%{line}"
end

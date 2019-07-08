# postfix-ruby

## Examples

```ruby
require './postfix-ruby'

PostFix::Program.new.eval([1]) { } # => 1
PostFix::Program.new.eval([]) { n 2 } # => 2
PostFix::Program.new.eval([]) { command { n 3 }; n 2; swap; exec } # => 3
PostFix::Program.new.eval([6]) do
  n 1
  nget
  n 0
  lt
  command { n 0; swap; sub }
  command {}
  sel
  exec
end # => 6
```

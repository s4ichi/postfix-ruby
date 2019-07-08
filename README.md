# postfix-ruby

## Examples

```ruby
PostFix::Program.new.eval([1]) { n 2 } # => 2
PostFix::Program.new.eval([]) { n 2 } # => 2
PostFix::Program.new.eval([]) { command { n 3 }; n 2; swap; exec } # => 3
```

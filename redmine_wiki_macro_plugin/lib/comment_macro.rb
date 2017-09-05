module WikiMacro


  Redmine::WikiFormatting::Macros.register do
    desc <<-eos
Make comment
Usage:
      {{comment(any,thing,...)
        anything....
        will not be processed
        anyway.
      }}
eos

    macro :comment, :parse_args => false do |obj, args, text|
      return ''
    end
  end

end

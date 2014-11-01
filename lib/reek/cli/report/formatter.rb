module Reek
  module Cli
    module Report
      module Formatter
        def self.format_list(warnings, formatter = SimpleWarningFormatter)
          warnings.map do |warning|
            "  #{formatter.format warning}"
          end.join("\n")
        end

        def self.header(examiner)
          count = examiner.smells_count
          result = Rainbow("#{examiner.description} -- ").cyan + Rainbow("#{count} warning").yellow
          result += Rainbow('s').yellow unless count == 1
          result
        end
      end

      module SimpleWarningFormatter
        def self.format(warning)
          "#{warning.context} #{warning.message} (#{warning.subclass})"
        end
      end

      module WarningFormatterWithLineNumbers
        def self.format(warning)
          "#{warning.lines.inspect}:#{SimpleWarningFormatter.format(warning)}"
        end
      end

      module SingleLineWarningFormatter
        def self.format(warning)
          "#{warning.source}:#{warning.lines.first}: #{SimpleWarningFormatter.format(warning)}"
        end
      end
    end
  end
end

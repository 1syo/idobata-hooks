module Idobata::Hook
  class Coveralls
    module Helper
      def message_from_coverage_change(coverage_change)
        if coverage_change.to_f > 0.0
          "coverage increased (#{coverage_change}) to"
        elsif  payload.coverage_change.to_f < 0.0
          "coverage decreased (#{coverage_change}) to"
        else
          "coverage remained the same at"
        end
      end

      def tow_places_of_float(covered_percent)
        sprintf("%.2f", covered_percent.to_f)
      end
    end
  end
end

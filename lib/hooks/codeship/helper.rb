module Idobata::Hook
  class Codeship
    module Helper
      def label_class_from_build_status(status)
        case status
          when 'success'
            'label-success'
          when 'error','stopped','infrastructure_failure'
            'label-danger'
          else
            'label-default'
          end
        end
    end
  end
end

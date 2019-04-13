module ButtonHelper

  class TriggerCode
    attr_reader :source

    def initialize(source)
      @source = source.to_s
      @comment = ""
    end

    def add_comment(comment)
      delimiter = @comment.empty? ? '' : ': '
      @comment += delimiter + comment
    end

    def eval(object, &block)
      log_suffix = "#{@comment} on object `#{object.id}`"

      if @source.blank?
        Rails.logger.info "=== #{log_suffix}: no code executed"

        return true
      end

      Rails.logger.info "=== #{log_suffix}: executing code #{@source}..."
      eval_result = object.instance_eval(@source)
      yield eval_result if block_given?
      Rails.logger.info "=== #{log_suffix}: finished executing code #{@source}..."
      true

    rescue WorkflowError => e
      Rails.logger.info "=== Trigger workflow error: #{e.message}"
      object.errors.add :base, e.error
      false
    rescue Exception => e
      Rails.logger.error "=== Trigger workflow exception: #{e.message}\n #{e.backtrace.join("\n ")}"
      object.errors.add :base, :custom_workflow_error
      false
    end
  end

  def self.load_code(model, attr)
    return nil unless model.has_attribute?(attr)
    code = model.read_attribute(attr)

    if model.has_attribute?(:is_file) && model.read_attribute(:is_file)
      Rails.logger.info "=== load_code: #{attr}: from URL: #{code}"

      return TriggerCode.new(self.read_from_url(code))
    end

    Rails.logger.info "=== load_code: #{attr}: inline"
    TriggerCode.new(code)
  end

  def self.read_from_url(url)
    nil
  end
end

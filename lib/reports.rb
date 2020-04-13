class Reports
  attr_accessor :decision_request
  def initialize(decision_request)
    @decision_request = decision_request
  end

  def fetch
    record = parser_class.parse(call_service)
    report = report_class.new(record)
    if report_class.new(record).save
      report
    else
      nil
    end
  end

  private

  def call_service
    service.constantize.call(request_payload)
  end

  def parser_class
    parser.constantize
  end

  def service
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def parser
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def report_class
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def request_payload
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

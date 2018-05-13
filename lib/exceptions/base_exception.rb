module ApiExceptions  
  class BaseException < StandardError
    include ActiveModel::Serialization
    attr_reader :status, :code, :message

    ERROR_DESCRIPTION = Proc.new {|code, message| {status: "error | failure", code: code, message: message}}
    ERROR_CODE_MAP = {
      "PurchaseError::MissingDatesError" =>
        ERROR_DESCRIPTION.call(3000, "Can't find purchases without start and end date"),
      "PurchaseError::ItemNotFound" =>
        ERROR_DESCRIPTION.call(4000, "item_id is required to make a purchase")
    }

    def initialize
      error_type = self.class.name.scan(/ApiExceptions::(.*)/).flatten.first
      ApiExceptions::BaseException::ERROR_CODE_MAP
        .fetch(error_type, {}).each do |attr, value|
          instance_variable_set("@#{attr}".to_sym, value)
      end
    end
  end
end  
class ApplicationController < ActionController::API

  def render_success_response(serialized_data, message, options={})
    json = {
      success: true,
      date: Time.now.utc,
      status: 200,
      messages: {success: message },
      data: serialized_data,
      meta: options
    }
    render json: json
  end

  def render_failure_response(errors, options={})
    json = {
      success: false,
      date: Time.now.utc,
      status: 200,
      messages: { errors: errors },
      data: {},
    }
    render json: json
  end

  def array_json(object, each_serializer, options={})
    ActiveModelSerializers::SerializableResource.new(object, each_serializer: each_serializer)
  end


end

require 'rubygems'
require 'sinatra'
require 'swagger/blocks'

# http://localhost:4567/hello

class ApiModel
  include Swagger::Blocks

  swagger_root host: 'localhost:4567' do
    key :swagger, '2.0'
    info version: '1.0.0' do
      key :title, 'Swagger PoC'
      key :description, 'Sample API'
      license do
        key :name, 'Apache-2.0'
      end
    end
  end

  swagger_path '/hello' do
    operation :get do
      key :description, 'Returns a greeting'
      response 200 do
        key :description, 'Hello response'
        schema do
          key :'$ref', :Hello
        end
      end
    end
  end

  swagger_schema :Hello do
    key :required, [:message]
    property :message do
      key :type, :string
    end
  end
end

# Say hello
get '/hello' do
  headers 'Access-Control-Allow-Origin' => '*'
  content_type :json
  JSON.pretty_generate({ message: 'it worked!' })
end

# Generate and serve Swagger 2.0 JSON
get '/swagger' do
  content_type :json
  JSON.pretty_generate Swagger::Blocks.build_root_json([ApiModel])
end

# Display Swagger UI
get '/ui' do
  swagger_url = '/swagger'
  unless params['url'] == swagger_url
    page_fragment = '#/default'
    redirect to("/ui?url=#{swagger_url}#{page_fragment}")
  end

  # http://localhost:4567/ui?url=/swagger#/default
  send_file File.expand_path('index.html', settings.public_folder)
end

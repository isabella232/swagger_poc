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
      response 200
    end
  end

  swagger_path '/swagger' do
    operation :get do
      key :description, 'Returns Swagger 2.0 JSON'
      response 200
    end
  end
end

get '/hello' do
  headers 'Access-Control-Allow-Origin' => '*'
  content_type :json
  { json: 'it worked!' }.to_json
end

get '/swagger' do
  # enable https://github.com/swagger-api/swagger-ui
  headers 'Access-Control-Allow-Origin' => '*'
  content_type :json
  Swagger::Blocks.build_root_json([ApiModel]).to_json
end

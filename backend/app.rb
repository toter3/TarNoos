require 'sinatra'
require 'json'

db = {
    "schema1" => {
        "tab1a" => [
            "culonmn1a1",
            "culonmn1a2",
            "culonmn1a3"
        ],
        "tab2a" => [
            "culonmn2a1",
            "culonmn2a2",
            "culonmn2a3"
        ],
        "tab3a" => [
            "culonmn3a1",
            "culonmn3a2",
            "culonmn3a3"
        ]
    },
    "schema2" => {
        "tab1a" => [
            "culonmn1b1",
            "culonmn1b2",
            "culonmn1b3"
        ],
        "tab2a" => [
            "culonmn2b1",
            "culonmn2b2",
            "culonmn2b3"
        ],
        "tab3a" => [
            "culonmn3b1",
            "culonmn3b2",
            "culonmn3b3"
        ]
    },
    "schema3" => {
        "tab1a" => [
            "culonmn1c1",
            "culonmn1c2",
            "culonmn1c3"
        ],
        "tab2a" => [
            "culonmn2c1",
            "culonmn2c2",
            "culonmn2c3"
        ],
        "tab3a" => [
            "culonmn3c1",
            "culonmn3c2",
            "culonmn3c3"
        ]
    },
}

before '/*' do

  headers({"Access-Control-Allow-Origin" => "*",
           "Access-Control-Allow-Headers" => "Content-Type",
           "Access-Control-Allow-Methods" => "GET, POST, OPTIONS"})

  sleep(0.5)

end

get '/get_schemas' do
  db.keys.map{|x| {"name" => x, "type" => "schema"}}.to_json
end

get '/get_tables' do
  schema = params["ancestors"][0]
  kof = db[schema].keys.map{|x| {"name" => x, "type" => "table", "ancestors" => [schema] }}
  kof.to_json
end

get '/get_columns' do
  schema, table = params["ancestors"]
  db[schema][table].map{|x| {"name" => x, "type" => "column", "ancestors" => [schema, table] }}.to_json
end


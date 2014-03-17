Elasticsearch::Model.client = Elasticsearch::Client.new host: CONFIG['elasticsearch']['host'], log: true, logger: Rails.logger

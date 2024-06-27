# frozen_string_literal: true

require 'rest-client'
require 'json'

module DoorLoop
  class Files
    MAX_FILE_SIZE = 50 * 1024 * 1024  # 50 MB

    def initialize(client)
      @client = client
      @logger = client.logger
    end

    def list(options = {})
      @client.get('files', options)
    end

    def retrieve(id)
      @client.get("files/#{id}")
    end

    def update(id, params)
      @client.put("files/#{id}", params)
    end

    def delete(id)
      @client.delete("files/#{id}")
    end

    def upload(file_path, params)
      unless params[:name] && params[:resourceType] && params[:resourceId]
        @logger.error("name, resourceType and resourceId are required parameters")
        return nil
      end

      file_size = File.size(file_path)
      if file_size > MAX_FILE_SIZE
        @logger.error("File size exceeds the 50MB limit")
        return nil
      end

      payload = {
        multipart: true,
        file: File.new(file_path, 'rb'),
        name: params[:name],
        resourceId: params[:resourceId],
        resourceType: params[:resourceType],
        notes: params[:notes],
        tags: params[:tags],
        size: params[:size] || file_size,
        mimeType: params[:mimeType],
        createdBy: params[:createdBy],
        createdAt: params[:createdAt]
      }.compact

      begin
        response = @client.post('files', payload)
      rescue RestClient::ExceptionWithResponse => e
        @logger.error("File upload failed: #{e.response}")
        @client.error_handler.handle(e)
      end
    end
  end
end

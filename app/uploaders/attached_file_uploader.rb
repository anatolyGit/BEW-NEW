# encoding: utf-8

class AttachedFileUploader < CarrierWave::Uploader::Base
  storage :file
end

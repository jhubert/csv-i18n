require 'csv'
require 'csv_i18n/ext'
require 'csv_i18n/version'

CSV.prepend CSVI18n::Ext

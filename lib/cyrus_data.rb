require 'cyrus_data/data_reader'
require 'cyrus_data/data_store'
require 'cyrus_data/data_writer'

data = DataReader.read

store = DataStore.new
store.store *data

DataWriter.write store.order_by :gender, :last_name, :ascending
DataWriter.write store.order_by :birthdate, :ascending
DataWriter.write store.order_by :last_name, :descending

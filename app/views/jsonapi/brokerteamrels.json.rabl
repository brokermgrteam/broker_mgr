object @brokerteamrels
attributes :broker_id => :broker, :lower_broker_id => :teambroker
node :status do |s|
  get_dict_by_id(s.status).name
end

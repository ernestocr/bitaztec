json.array! @notifications do |notification|
  # json.recipient notification.recipient
  # json.action notification.action
  
  if notification.action == 'completed'
    json.action 'completado'
  elsif notification.action == 'denied'
    json.action 'denegado'
  elsif notification.action == 'expired'
    json.action 'expirado'
  else
    json.action notification.action
  end

  json.notifiable do # notification.notifiable
    json.type notification.notifiable.class.model_name.human.underscore
  end
  
  json.url order_path(notification.notifiable)
end

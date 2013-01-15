# Description:
#   checks for trello notifications at a specified interval and posts them
#
# Dependencies:
#   "node-trello": "latest"
#
# Configuration:
#   HUBOT_TRELLO_KEY
#   HUBOT_TRELLO_TOKEN
#   HUBOT_TRELLO_ROOM
#
# Commands:
#   None
#

env = process.env

interval = 10000 # 30s

Trello = require 'node-trello'

messages = require '../resources/trello-notifications.strings.coffee'

module.exports = (robot) ->
  if env.HUBOT_TRELLO_KEY? and env.HUBOT_TRELLO_TOKEN? and env.HUBOT_TRELLO_ROOM?
    t = new Trello env.HUBOT_TRELLO_KEY, env.HUBOT_TRELLO_TOKEN
    room = env.HUBOT_TRELLO_ROOM

    if t then setInterval ->
      console.log 'Trello: Polling for notifications'
      t.get '/1/members/me/notifications', (err, data) ->
        if err 
          robot.messageRoom 'Hubot Errors', 'Error receiving trello notifications.'
          console.log err
          return

        for notification in data
          if not notification.unread then break
          console.log 'Trello: New notification, posting...'
          
          message = messages[notification.type]
          
          if notification.data.old
            @key = 'def'
            for property in Object.keys(notification.data.old)
              @key = property
              break;

            message = message[key]

          message = message notification
          url = "http://trello.com/card/#{notification.data.card.id}/1"

          robot.messageRoom.apply robot, [room, 'New Trello Notification:'].concat message, url
    , interval
  else
    console.log 'Trello API keys not set'
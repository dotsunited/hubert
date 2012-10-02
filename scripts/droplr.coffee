# Description:
#   Allow Hubot to show the image of a droplr link
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   http://d.pr/i/* - Detects the url and displays the image
#
# Author:
#   maggo

module.exports = (robot) ->
  robot.hear /https?:\/\/d.pr\/i\/(.*)/i, (msg) ->
    msg.http(msg.match[0] + '+')
      .get() (err, res, body) ->
        if err? or res.statusCode == 404
          msg.send 'Couldn\'t find that image'
        else
          msg.send res.headers.location

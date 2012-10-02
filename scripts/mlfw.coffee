# Description:
#   Pugme is the most important thing in your life
#
# Commands:
#   hubot pug me - Receive a pug
#   hubot pug bomb N - get N pugs

module.exports = (robot) ->

  robot.hear /^(mlfw|my little face when)\s?(.*)$/i, (msg) ->
    search = if msg.match[2] then 'search=["'+msg.match[2]+'"]&' else ''
    url = 'http://mylittlefacewhen.com/api/v2/face/?'+search+'order_by=random&format=json)'
    msg.http(url)
      .get() (err, res, body) ->
        data = JSON.parse(body) if not err and res.statusCode isnt 404
        if not data? or data.objects.length 
          msg.send 'http://mylittlefacewhen.com' + data.objects[0].image
        else
          msg.send 'No images found'


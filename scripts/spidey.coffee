# Description:
#   Post 60s spiderman
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot post spidey - post random 60s spiderman images
#
# Author:
#   maggo


module.exports = (robot) ->
  robot.respond /post spidey/i, (msg) ->
    tumblr_request = (offset, success) ->
      params = { api_key: process.env.HUBOT_TUMBLR_API_KEY, limit: 1, offset: offset }
      msg.http('http://api.tumblr.com/v2/blog/fuck-yeah-spider-man.tumblr.com/posts/photo')
        .query(params)
        .get() (err, res, body) ->
          if err
            robot.logger.error err
          else if res.statusCode != 200
            robot.logger.error "Received status code #{res.statusCode}."
          else
            success JSON.parse(body)

    tumblr_request 0, (data) ->
      total_posts = data.response.total_posts
      offset = Math.round((total_posts - 1) * Math.random())
      tumblr_request offset, (data) ->
        post = data.response.posts.pop()
        msg.send post.photos.pop().original_size.url
    

module('Likes')

test 'should updateStatus', ->
  $fixture = $('#qunit-fixture')
  $fixture.append("
  <a id='like-for-topic-1'></a>
  <a id='like-for-comment-1'></a>
  <a id='like-for-comment-2'></a>
  <a id='like-for-comment-3'></a>
  ")

  campo.Likes.updateLike('topic', 1)
  ok $fixture.find('#like-for-topic-1').hasClass('liked')

  campo.Likes.updateLikes('comment', [1,2])
  ok $fixture.find('#like-for-comment-1').hasClass('liked')
  ok $fixture.find('#like-for-comment-2').hasClass('liked')
  ok !$fixture.find('#like-for-comment-3').hasClass('liked')

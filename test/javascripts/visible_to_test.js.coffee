module('visible-to')

test 'should keep element for user if logined', ->
  $fixture = $('#qunit-fixture')
  $fixture.append("
  <div data-visible-to='user'></div>
  ")

  campo.currentUser = { id: 1 }
  campo.VisibleTo.check()

  ok($fixture.find('div').length)

  # clear
  campo.currentUser = null

test 'should remove element for user if logined', ->
  $fixture = $('#qunit-fixture')
  $fixture.append("
  <div data-visible-to='user'></div>
  ")

  campo.VisibleTo.check()

  ok(!$fixture.find('div').length)

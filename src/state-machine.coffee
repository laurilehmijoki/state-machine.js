class State
  constructor: (@entryAction, @exitAction) ->

class CyclicStateMachine
  constructor: (@states) ->

  start: =>
    @currentStateIndex = 0
    @isStarted = true
    @currentState().entryAction()
    this

  currentState: =>
    unless @isStarted
      throw 'State machine not started. Invoke #start first.'
    @states[@currentStateIndex]

  transition: =>
    oldState = @currentState()
    @currentStateIndex = @nextStateIndex()
    oldState.exitAction()
    @currentState().entryAction()
    this

  nextStateIndex: =>
    if @currentStateIndex == @states.length - 1
      0
    else
      @currentStateIndex + 1

StateMachine = @StateMachine = {}
StateMachine.State = State
StateMachine.CyclicStateMachine = CyclicStateMachine
